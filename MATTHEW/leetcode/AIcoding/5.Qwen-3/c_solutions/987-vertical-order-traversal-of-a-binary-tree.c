#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct QueueNode {
    struct TreeNode *node;
    int hd;
    struct QueueNode *next;
} QueueNode;

typedef struct Queue {
    QueueNode *front;
    QueueNode *rear;
} Queue;

typedef struct Pair {
    int hd;
    int val;
} Pair;

typedef struct List {
    int size;
    Pair *data;
} List;

typedef struct HashTable {
    int key;
    List *list;
    struct HashTable *next;
} HashTable;

Queue *createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue *q, TreeNode *node, int hd) {
    QueueNode *newNode = (QueueNode *)malloc(sizeof(QueueNode));
    newNode->node = node;
    newNode->hd = hd;
    newNode->next = NULL;
    if (!q->front) {
        q->front = q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

int dequeue(Queue *q, TreeNode **node, int *hd) {
    if (!q->front) return 0;
    QueueNode *temp = q->front;
    *node = temp->node;
    *hd = temp->hd;
    q->front = q->front->next;
    free(temp);
    return 1;
}

void freeQueue(Queue *q) {
    while (q->front) {
        QueueNode *temp = q->front;
        q->front = q->front->next;
        free(temp);
    }
    free(q);
}

List *createList() {
    List *lst = (List *)malloc(sizeof(List));
    lst->size = 0;
    lst->data = NULL;
    return lst;
}

void addToList(List *lst, int hd, int val) {
    lst->size++;
    lst->data = (Pair *)realloc(lst->data, lst->size * sizeof(Pair));
    lst->data[lst->size - 1].hd = hd;
    lst->data[lst->size - 1].val = val;
}

void sortList(List *lst) {
    for (int i = 0; i < lst->size - 1; i++) {
        for (int j = 0; j < lst->size - i - 1; j++) {
            if (lst->data[j].hd > lst->data[j + 1].hd || 
                (lst->data[j].hd == lst->data[j + 1].hd && lst->data[j].val > lst->data[j + 1].val)) {
                Pair temp = lst->data[j];
                lst->data[j] = lst->data[j + 1];
                lst->data[j + 1] = temp;
            }
        }
    }
}

HashTable *createHashTable() {
    HashTable *ht = (HashTable *)malloc(sizeof(HashTable));
    ht->key = 0;
    ht->list = createList();
    ht->next = NULL;
    return ht;
}

void insertIntoHashTable(HashTable *ht, int hd, int val) {
    HashTable *current = ht;
    while (current->next && current->next->key != hd) {
        current = current->next;
    }
    if (current->next && current->next->key == hd) {
        addToList(current->next->list, hd, val);
    } else {
        HashTable *newNode = (HashTable *)malloc(sizeof(HashTable));
        newNode->key = hd;
        newNode->list = createList();
        newNode->next = current->next;
        current->next = newNode;
        addToList(newNode->list, hd, val);
    }
}

void freeHashTable(HashTable *ht) {
    HashTable *current = ht;
    while (current) {
        HashTable *next = current->next;
        free(current->list->data);
        free(current->list);
        free(current);
        current = next;
    }
}

int *getColumnValues(HashTable *ht, int *returnSize) {
    HashTable *current = ht->next;
    int count = 0;
    while (current) {
        count += current->list->size;
        current = current->next;
    }
    *returnSize = count;
    int *result = (int *)malloc(count * sizeof(int));
    int index = 0;
    current = ht->next;
    while (current) {
        sortList(current->list);
        for (int i = 0; i < current->list->size; i++) {
            result[index++] = current->list->data[i].val;
        }
        current = current->next;
    }
    return result;
}

int** verticalOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    Queue *q = createQueue();
    enqueue(q, root, 0);

    HashTable *ht = createHashTable();

    while (dequeue(q, &root, &root->val)) {
        insertIntoHashTable(ht, root->val, root->val);
        if (root->left) {
            enqueue(q, root->left, root->val - 1);
        }
        if (root->right) {
            enqueue(q, root->right, root->val + 1);
        }
    }

    freeQueue(q);

    int totalColumns = 0;
    HashTable *current = ht->next;
    while (current) {
        totalColumns++;
        current = current->next;
    }

    *returnSize = totalColumns;
    int **result = (int **)malloc(totalColumns * sizeof(int *));
    *returnColumnSizes = (int *)malloc(totalColumns * sizeof(int));

    current = ht->next;
    int idx = 0;
    while (current) {
        int size = current->list->size;
        (*returnColumnSizes)[idx] = size;
        result[idx] = (int *)malloc(size * sizeof(int));
        for (int i = 0; i < size; i++) {
            result[idx][i] = current->list->data[i].val;
        }
        idx++;
        current = current->next;
    }

    freeHashTable(ht);

    return result;
}