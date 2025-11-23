#include <stdlib.h> // For malloc, free

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode *root;
    struct TreeNode **queue; // Array to simulate a queue of potential parent nodes
    int head;
    int tail;
    int capacity;
} CBTInserter;

struct TreeNode* createNode(int val) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

CBTInserter* cBTInserterCreate(struct TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->root = root;
    obj->capacity = 1005; // Max nodes 1000, so 1005 is a safe capacity for the queue
    obj->queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
    obj->head = 0;
    obj->tail = 0;

    // Use a temporary BFS queue to initialize obj->queue with potential parents
    // Nodes that have less than two children are potential parents.
    struct TreeNode* temp_bfs_q[1005]; // Max 1000 nodes
    int temp_bfs_head = 0;
    int temp_bfs_tail = 0;

    if (root) {
        temp_bfs_q[temp_bfs_tail++] = root;
        while (temp_bfs_head < temp_bfs_tail) {
            struct TreeNode* curr = temp_bfs_q[temp_bfs_head++];

            // If curr has less than two children, it's a potential parent for insertion
            if (curr->left == NULL || curr->right == NULL) {
                obj->queue[obj->tail++] = curr;
            }

            if (curr->left) {
                temp_bfs_q[temp_bfs_tail++] = curr->left;
            }
            if (curr->right) {
                temp_bfs_q[temp_bfs_tail++] = curr->right;
            }
        }
    }

    return obj;
}

int cBTInserterInsert(CBTInserter* obj, int val) {
    struct TreeNode* parent = obj->queue[obj->head];
    struct TreeNode* newNode = createNode(val);

    if (parent->left == NULL) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    // The newly inserted node is also a potential parent for future insertions
    obj->queue[obj->tail++] = newNode;

    // If the parent now has two children, it's no longer a candidate for insertion
    if (parent->left && parent->right) {
        obj->head++; // Dequeue the parent
    }

    return parent->val;
}

struct TreeNode* cBTInserterGet_root(CBTInserter* obj) {
    return obj->root;
}

void cBTInserterFree(CBTInserter* obj) {
    free(obj->queue);
    free(obj);
}