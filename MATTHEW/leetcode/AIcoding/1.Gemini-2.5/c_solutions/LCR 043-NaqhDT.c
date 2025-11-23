#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** nodes;
    int head;
    int tail;
    int size;
    int capacity;
} TreeNodeQueue;

void TreeNodeQueue_init(TreeNodeQueue* q, int initial_capacity) {
    q->nodes = (struct TreeNode**)malloc(initial_capacity * sizeof(struct TreeNode*));
    q->head = 0;
    q->tail = 0;
    q->size = 0;
    q->capacity = initial_capacity;
}

bool TreeNodeQueue_is_empty(TreeNodeQueue* q) {
    return q->size == 0;
}

bool TreeNodeQueue_is_full(TreeNodeQueue* q) {
    return q->size == q->capacity;
}

void TreeNodeQueue_resize(TreeNodeQueue* q) {
    int new_capacity = q->capacity * 2;
    if (new_capacity == 0) new_capacity = 1; 

    struct TreeNode** new_nodes = (struct TreeNode**)malloc(new_capacity * sizeof(struct TreeNode*));

    for (int i = 0; i < q->size; i++) {
        new_nodes[i] = q->nodes[(q->head + i) % q->capacity];
    }

    free(q->nodes);
    q->nodes = new_nodes;
    q->head = 0;
    q->tail = q->size;
    q->capacity = new_capacity;
}

void TreeNodeQueue_enqueue(TreeNodeQueue* q, struct TreeNode* node) {
    if (TreeNodeQueue_is_full(q)) {
        TreeNodeQueue_resize(q);
    }
    q->nodes[q->tail] = node;
    q->tail = (q->tail + 1) % q->capacity;
    q->size++;
}

struct TreeNode* TreeNodeQueue_dequeue(TreeNodeQueue* q) {
    struct TreeNode* node = q->nodes[q->head];
    q->head = (q->head + 1) % q->capacity;
    q->size--;
    return node;
}

struct TreeNode* TreeNodeQueue_peek(TreeNodeQueue* q) {
    return q->nodes[q->head];
}

void TreeNodeQueue_free(TreeNodeQueue* q) {
    free(q->nodes);
    q->nodes = NULL;
    q->head = 0;
    q->tail = 0;
    q->size = 0;
    q->capacity = 0;
}

typedef struct {
    struct TreeNode* root;
    TreeNodeQueue parent_candidates;
} CBTInserter;

#define INITIAL_QUEUE_CAPACITY 2048

CBTInserter* cBTInserterCreate(struct TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->root = root;
    TreeNodeQueue_init(&obj->parent_candidates, INITIAL_QUEUE_CAPACITY);

    TreeNodeQueue bfs_queue;
    TreeNodeQueue_init(&bfs_queue, INITIAL_QUEUE_CAPACITY);
    TreeNodeQueue_enqueue(&bfs_queue, root);

    while (!TreeNodeQueue_is_empty(&bfs_queue)) {
        struct TreeNode* curr = TreeNodeQueue_dequeue(&bfs_queue);

        if (curr->left == NULL || curr->right == NULL) {
            TreeNodeQueue_enqueue(&obj->parent_candidates, curr);
        }

        if (curr->left != NULL) {
            TreeNodeQueue_enqueue(&bfs_queue, curr->left);
        }
        if (curr->right != NULL) {
            TreeNodeQueue_enqueue(&bfs_queue, curr->right);
        }
    }

    TreeNodeQueue_free(&bfs_queue);

    return obj;
}

int cBTInserterInsert(CBTInserter* obj, int val) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;

    struct TreeNode* parent = TreeNodeQueue_peek(&obj->parent_candidates);

    if (parent->left == NULL) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    TreeNodeQueue_enqueue(&obj->parent_candidates, newNode);

    if (parent->left != NULL && parent->right != NULL) {
        TreeNodeQueue_dequeue(&obj->parent_candidates);
    }

    return parent->val;
}

struct TreeNode* cBTInserterGetRoot(CBTInserter* obj) {
    return obj->root;
}

void cBTInserterFree(CBTInserter* obj) {
    TreeNodeQueue_free(&obj->parent_candidates);
    free(obj);
}