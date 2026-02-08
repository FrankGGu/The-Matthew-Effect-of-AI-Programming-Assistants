typedef struct Node {
    int key;
    int value;
    int freq;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct FreqList {
    int freq;
    Node* head;
    Node* tail;
    struct FreqList* prev;
    struct FreqList* next;
} FreqList;

typedef struct {
    int capacity;
    int size;
    int minFreq;
    Node** keyMap;
    FreqList** freqMap;
    FreqList* freqHead;
} LFUCache;

Node* createNode(int key, int value) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->key = key;
    node->value = value;
    node->freq = 1;
    node->prev = NULL;
    node->next = NULL;
    return node;
}

FreqList* createFreqList(int freq) {
    FreqList* fl = (FreqList*)malloc(sizeof(FreqList));
    fl->freq = freq;
    fl->head = createNode(-1, -1);
    fl->tail = createNode(-1, -1);
    fl->head->next = fl->tail;
    fl->tail->prev = fl->head;
    fl->prev = NULL;
    fl->next = NULL;
    return fl;
}

void removeNode(Node* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
}

void addNodeToHead(Node* head, Node* node) {
    node->next = head->next;
    node->prev = head;
    head->next->prev = node;
    head->next = node;
}

void removeFreqList(FreqList* fl) {
    fl->prev->next = fl->next;
    if (fl->next) fl->next->prev = fl->prev;
}

void addFreqListAfter(FreqList* prevFl, FreqList* newFl) {
    newFl->next = prevFl->next;
    newFl->prev = prevFl;
    if (prevFl->next) prevFl->next->prev = newFl;
    prevFl->next = newFl;
}

LFUCache* lFUCacheCreate(int capacity) {
    LFUCache* cache = (LFUCache*)malloc(sizeof(LFUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->minFreq = 0;
    cache->keyMap = (Node**)calloc(100000, sizeof(Node*));
    cache->freqMap = (FreqList**)calloc(100000, sizeof(FreqList*));
    cache->freqHead = createFreqList(0);
    return cache;
}

void updateNode(LFUCache* obj, Node* node) {
    int oldFreq = node->freq;
    FreqList* oldFl = obj->freqMap[oldFreq];

    removeNode(node);

    if (oldFl->head->next == oldFl->tail) {
        if (obj->minFreq == oldFreq) obj->minFreq++;
        removeFreqList(oldFl);
        obj->freqMap[oldFreq] = NULL;
        free(oldFl->head);
        free(oldFl->tail);
        free(oldFl);
    }

    node->freq++;
    int newFreq = node->freq;
    FreqList* newFl = obj->freqMap[newFreq];

    if (!newFl) {
        newFl = createFreqList(newFreq);
        FreqList* current = obj->freqHead;
        while (current->next && current->next->freq <= newFreq) {
            current = current->next;
        }
        addFreqListAfter(current, newFl);
        obj->freqMap[newFreq] = newFl;
    }

    addNodeToHead(newFl->head, node);
}

int lFUCacheGet(LFUCache* obj, int key) {
    if (obj->capacity == 0) return -1;

    Node* node = obj->keyMap[key];
    if (!node) return -1;

    updateNode(obj, node);
    return node->value;
}

void lFUCachePut(LFUCache* obj, int key, int value) {
    if (obj->capacity == 0) return;

    Node* node = obj->keyMap[key];
    if (node) {
        node->value = value;
        updateNode(obj, node);
        return;
    }

    if (obj->size == obj->capacity) {
        FreqList* minFl = obj->freqMap[obj->minFreq];
        Node* lruNode = minFl->tail->prev;
        removeNode(lruNode);
        obj->keyMap[lruNode->key] = NULL;
        free(lruNode);
        obj->size--;

        if (minFl->head->next == minFl->tail) {
            removeFreqList(minFl);
            obj->freqMap[obj->minFreq] = NULL;
            free(minFl->head);
            free(minFl->tail);
            free(minFl);
        }
    }

    node = createNode(key, value);
    obj->keyMap[key] = node;
    obj->size++;
    obj->minFreq = 1;

    FreqList* fl = obj->freqMap[1];
    if (!fl) {
        fl = createFreqList(1);
        addFreqListAfter(obj->freqHead, fl);
        obj->freqMap[1] = fl;
    }

    addNodeToHead(fl->head, node);
}

void lFUCacheFree(LFUCache* obj) {
    for (int i = 0; i < 100000; i++) {
        if (obj->keyMap[i]) free(obj->keyMap[i]);
    }
    free(obj->keyMap);

    FreqList* current = obj->freqHead;
    while (current) {
        FreqList* next = current->next;
        free(current->head);
        free(current->tail);
        free(current);
        current = next;
    }

    free(obj->freqMap);
    free(obj);
}

/**
 * Your LFUCache struct will be instantiated and called as such:
 * LFUCache* obj = lFUCacheCreate(capacity);
 * int param_1 = lFUCacheGet(obj, key);

 * lFUCachePut(obj, key, value);

 * lFUCacheFree(obj);
*/