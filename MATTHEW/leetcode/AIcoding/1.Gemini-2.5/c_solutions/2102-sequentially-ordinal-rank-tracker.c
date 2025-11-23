#include <stdlib.h>
#include <string.h>

#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

typedef struct Location {
    char name[17]; // Max name length 16 + null terminator
    int score;
} Location;

typedef struct AVLNode {
    Location loc;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
    int count; // Number of nodes in this subtree
} AVLNode;

int getHeight(AVLNode* node) {
    return node ? node->height : 0;
}

int getCount(AVLNode* node) {
    return node ? node->count : 0;
}

void updateHeight(AVLNode* node) {
    if (node) {
        node->height = 1 + MAX(getHeight(node->left), getHeight(node->right));
    }
}

void updateCount(AVLNode* node) {
    if (node) {
        node->count = 1 + getCount(node->left) + getCount(node->right);
    }
}

int getBalance(AVLNode* node) {
    if (node == NULL) return 0;
    return getHeight(node->left) - getHeight(node->right);
}

AVLNode* rightRotate(AVLNode* y) {
    AVLNode* x = y->left;
    AVLNode* T2 = x->right;

    // Perform rotation
    x->right = y;
    y->left = T2;

    // Update heights and counts
    updateHeight(y);
    updateCount(y);
    updateHeight(x);
    updateCount(x);

    return x;
}

AVLNode* leftRotate(AVLNode* x) {
    AVLNode* y = x->right;
    AVLNode* T2 = y->left;

    // Perform rotation
    y->left = x;
    x->right = T2;

    // Update heights and counts
    updateHeight(x);
    updateCount(x);
    updateHeight(y);
    updateCount(y);

    return y;
}

int compareLocations(const Location* a, const Location* b) {
    if (a->score != b->score) {
        return (a->score > b->score) ? -1 : 1; // Higher score is better
    }
    // Scores are equal, compare names lexicographically
    int name_cmp = strcmp(a->name, b->name);
    if (name_cmp != 0) {
        return (name_cmp < 0) ? -1 : 1; // Lexicographically smaller name is better
    }
    return 0; // Identical locations (should not happen with unique names)
}

AVLNode* insert(AVLNode* node, Location newLoc) {
    // 1. Perform standard BST insertion
    if (node == NULL) {
        AVLNode* newNode = (AVLNode*)malloc(sizeof(AVLNode));
        newNode->loc = newLoc; // Struct copy
        newNode->left = NULL;
        newNode->right = NULL;
        newNode->height = 1;
        newNode->count = 1;
        return newNode;
    }

    int cmp = compareLocations(&newLoc, &(node->loc));
    if (cmp < 0) { // newLoc is better, go left
        node->left = insert(node->left, newLoc);
    } else if (cmp > 0) { // newLoc is worse, go right
        node->right = insert(node->right, newLoc);
    } else {
        // Duplicate location (same name and score), assuming problem guarantees unique names.
        return node;
    }

    // 2. Update height and count of this ancestor node
    updateHeight(node);
    updateCount(node);

    // 3. Get the balance factor
    int balance = getBalance(node);

    // 4. If unbalanced, perform rotations
    // Left Left Case
    if (balance > 1 && compareLocations(&newLoc, &(node->left->loc)) < 0) {
        return rightRotate(node);
    }
    // Right Right Case
    if (balance < -1 && compareLocations(&newLoc, &(node->right->loc)) > 0) {
        return leftRotate(node);
    }
    // Left Right Case
    if (balance > 1 && compareLocations(&newLoc, &(node->left->loc)) > 0) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }
    // Right Left Case
    if (balance < -1 && compareLocations(&newLoc, &(node->right->loc)) < 0) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

const Location* findKth(AVLNode* node, int k) {
    if (node == NULL) return NULL; 

    int left_count = getCount(node->left);

    if (k == left_count) {
        return &(node->loc); // This node is the k-th element
    } else if (k < left_count) {
        return findKth(node->left, k); // K-th is in the left subtree
    } else {
        // K-th is in the right subtree. Adjust k for the right subtree.
        return findKth(node->right, k - left_count - 1);
    }
}

typedef struct {
    AVLNode *root;
    int get_count; // Number of times get() has been called
} SORTracker;

SORTracker* sORTrackerCreate() {
    SORTracker* obj = (SORTracker*)malloc(sizeof(SORTracker));
    obj->root = NULL;
    obj->get_count = 0;
    return obj;
}

void sORTrackerAdd(SORTracker* obj, char *name, int score) {
    Location newLoc;
    strncpy(newLoc.name, name, 16);
    newLoc.name[16] = '\0'; // Ensure null termination
    newLoc.score = score;
    obj->root = insert(obj->root, newLoc);
}

char* sORTrackerGet(SORTracker* obj) {
    obj->get_count++;
    // get_count is 1-indexed for the problem, findKth is 0-indexed
    const Location* kth_loc = findKth(obj->root, obj->get_count - 1);

    // LeetCode expects a dynamically allocated string for the return value
    char* result_name = (char*)malloc(sizeof(char) * (strlen(kth_loc->name) + 1));
    strcpy(result_name, kth_loc->name);
    return result_name;
}

void freeTree(AVLNode* node) {
    if (node == NULL) return;
    freeTree(node->left);
    freeTree(node->right);
    free(node);
}

void sORTrackerFree(SORTracker* obj) {
    freeTree(obj->root);
    free(obj);
}