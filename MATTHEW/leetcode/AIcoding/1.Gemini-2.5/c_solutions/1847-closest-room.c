#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int id;
    int size;
} Room;

typedef struct {
    int minSize;
    int preferredId;
    int originalIndex;
} Query;

int compareRoomsBySizeDesc(const void *a, const void *b) {
    return ((Room *)b)->size - ((Room *)a)->size;
}

int compareQueriesByMinSizeDesc(const void *a, const void *b) {
    return ((Query *)b)->minSize - ((Query *)a)->minSize;
}

typedef struct BSTNode {
    int id;
    struct BSTNode *left;
    struct BSTNode *right;
    int height; // For AVL balancing
} BSTNode;

int height(BSTNode *N) {
    if (N == NULL)
        return 0;
    return N->height;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

BSTNode *newNode(int id) {
    BSTNode *node = (BSTNode *)malloc(sizeof(BSTNode));
    node->id = id;
    node->left = NULL;
    node->right = NULL;
    node->height = 1; // New node is initially added at leaf
    return node;
}

BSTNode *rightRotate(BSTNode *y) {
    BSTNode *x = y->left;
    BSTNode *T2 = x->right;

    // Perform rotation
    x->right = y;
    y->left = T2;

    // Update heights
    y->height = max(height(y->left), height(y->right)) + 1;
    x->height = max(height(x->left), height(x->right)) + 1;

    // Return new root
    return x;
}

BSTNode *leftRotate(BSTNode *x) {
    BSTNode *y = x->right;
    BSTNode *T2 = y->left;

    // Perform rotation
    y->left = x;
    x->right = T2;

    // Update heights
    x->height = max(height(x->left), height(x->right)) + 1;
    y->height = max(height(y->left), height(y->right)) + 1;

    // Return new root
    return y;
}

int getBalance(BSTNode *N) {
    if (N == NULL)
        return 0;
    return height(N->left) - height(N->right);
}

BSTNode *insert(BSTNode *node, int id) {
    // 1. Perform the normal BST insertion
    if (node == NULL)
        return newNode(id);

    if (id < node->id)
        node->left = insert(node->left, id);
    else if (id > node->id)
        node->right = insert(node->right, id);
    else // Duplicate IDs are not allowed
        return node;

    // 2. Update height of this ancestor node
    node->height = 1 + max(height(node->left), height(node->right));

    // 3. Get the balance factor of this ancestor node to check whether
    //    this node became unbalanced
    int balance = getBalance(node);

    // If this node becomes unbalanced, then there are 4 cases

    // Left Left Case
    if (balance > 1 && id < node->left->id)
        return rightRotate(node);

    // Right Right Case
    if (balance < -1 && id > node->right->id)
        return leftRotate(node);

    // Left Right Case
    if (balance > 1 && id > node->left->id) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // Right Left Case
    if (balance < -1 && id < node->right->id) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    // Return the (unchanged) node pointer
    return node;
}

int findClosest(BSTNode *root, int preferredId) {
    if (root == NULL) {
        return -1; // No rooms available
    }

    int closestId = -1;
    int minDiff = 2000000000; // A sufficiently large number

    BSTNode *current = root;
    while (current != NULL) {
        int currentDiff = abs(current->id - preferredId);

        if (closestId == -1 || currentDiff < minDiff ||
            (currentDiff == minDiff && current->id < closestId)) {
            minDiff = currentDiff;
            closestId = current->id;
        }

        if (preferredId < current->id) {
            current = current->left;
        } else if (preferredId > current->id) {
            current = current->right;
        } else { // preferredId found exactly
            return preferredId;
        }
    }
    return closestId;
}

void freeAVLTree(BSTNode *node) {
    if (node == NULL) {
        return;
    }
    freeAVLTree(node->left);
    freeAVLTree(node->right);
    free(node);
}

int* closestRoom(int** rooms, int roomsSize, int* roomsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(sizeof(int) * queriesSize);

    // Prepare rooms for sorting
    Room* roomObjs = (Room*)malloc(sizeof(Room) * roomsSize);
    for (int i = 0; i < roomsSize; ++i) {
        roomObjs[i].id = rooms[i][0];
        roomObjs[i].size = rooms[i][1];
    }
    qsort(roomObjs, roomsSize, sizeof(Room), compareRoomsBySizeDesc);

    // Prepare queries for sorting
    Query* queryObjs = (Query*)malloc(sizeof(Query) * queriesSize);
    for (int i = 0; i < queriesSize; ++i) {
        queryObjs[i].preferredId = queries[i][0];
        queryObjs[i].minSize = queries[i][1];
        queryObjs[i].originalIndex = i;
    }
    qsort(queryObjs, queriesSize, sizeof(Query), compareQueriesByMinSizeDesc);

    BSTNode *roomIdsTree = NULL;
    int roomIdx = 0;

    for (int i = 0; i < queriesSize; ++i) {
        // Add rooms whose size is >= current query's minSize
        while (roomIdx < roomsSize && roomObjs[roomIdx].size >= queryObjs[i].minSize) {
            roomIdsTree = insert(roomIdsTree, roomObjs[roomIdx].id);
            roomIdx++;
        }

        // Find the closest room ID in the current set of available rooms
        result[queryObjs[i].originalIndex] = findClosest(roomIdsTree, queryObjs[i].preferredId);
    }

    free(roomObjs);
    free(queryObjs);
    freeAVLTree(roomIdsTree); // Free the AVL tree nodes

    return result;
}