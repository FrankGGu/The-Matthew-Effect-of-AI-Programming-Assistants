typedef struct Node {
    struct Node *prev;
    struct Node *next;
    int count;
    struct HashSet *keys;
} Node;

typedef struct HashSet {
    char *key;
    struct HashSet *next;
} HashSet;

typedef struct AllOne {
    struct Node *head;
    struct Node *tail;
    struct HashMap *map;
} AllOne;

AllOne* allOneCreate() {
    AllOne *obj = (AllOne *)malloc(sizeof(AllOne));
    obj->head = (Node *)malloc(sizeof(Node));
    obj->tail = (Node *)malloc(sizeof(Node));
    obj->head->next = obj->tail;
    obj->tail->prev = obj->head;
    obj->head->count = 0;
    obj->tail->count = 0;
    obj->head->keys = NULL;
    obj->tail->keys = NULL;
    obj->map = (HashMap *)malloc(sizeof(HashMap));
    return obj;
}

void insertNode(AllOne *obj, Node *newNode) {
    newNode->prev = obj->head;
    newNode->next = obj->head->next;
    obj->head->next->prev = newNode;
    obj->head->next = newNode;
}

void removeNode(AllOne *obj, Node *node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
    free(node);
}

void inc(AllOne* obj, char *key) {
    // Increment logic goes here
}

void dec(AllOne* obj, char *key) {
    // Decrement logic goes here
}

char* getMaxKey(AllOne* obj) {
    // Return max key logic goes here
}

char* getMinKey(AllOne* obj) {
    // Return min key logic goes here
}

void allOneFree(AllOne* obj) {
    // Free memory logic goes here
}