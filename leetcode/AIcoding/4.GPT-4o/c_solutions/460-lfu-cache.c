typedef struct {
    int key;
    int value;
    int frequency;
} Node;

typedef struct {
    Node* node;
    struct ListNode* next;
} ListNode;

typedef struct {
    ListNode** frequencyList;
    int* frequencyCount;
    int capacity;
    int size;
    int minFrequency;
    int* keyToFrequency;
    Node* keyToNode;
} LFUCache;

LFUCache* lfuCacheCreate(int capacity) {
    LFUCache* cache = (LFUCache*)malloc(sizeof(LFUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->minFrequency = 0;
    cache->frequencyList = (ListNode**)malloc(sizeof(ListNode*) * (capacity + 1));
    cache->frequencyCount = (int*)calloc(capacity + 1, sizeof(int));
    cache->keyToFrequency = (int*)malloc(sizeof(int) * (capacity + 1));
    cache->keyToNode = (Node*)malloc(sizeof(Node) * (capacity + 1));
    return cache;
}

void lfuCacheFree(LFUCache* obj) {
    for (int i = 0; i <= obj->capacity; i++) {
        ListNode* node = obj->frequencyList[i];
        while (node) {
            ListNode* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(obj->frequencyList);
    free(obj->frequencyCount);
    free(obj->keyToFrequency);
    free(obj->keyToNode);
    free(obj);
}

void updateFrequency(LFUCache* cache, int key) {
    int freq = cache->keyToFrequency[key];
    cache->frequencyCount[freq]--;
    if (cache->frequencyCount[freq] == 0 && freq == cache->minFrequency) {
        cache->minFrequency++;
    }
    cache->keyToFrequency[key]++;
    freq++;
    ListNode* newNode = (ListNode*)malloc(sizeof(ListNode));
    newNode->node = &cache->keyToNode[key];
    newNode->next = cache->frequencyList[freq];
    cache->frequencyList[freq] = newNode;
    cache->frequencyCount[freq]++;
}

int lfuCacheGet(LFUCache* obj, int key) {
    if (obj->capacity == 0 || obj->keyToNode[key].key == 0) {
        return -1;
    }
    updateFrequency(obj, key);
    return obj->keyToNode[key].value;
}

void lfuCachePut(LFUCache* obj, int key, int value) {
    if (obj->capacity == 0) return;
    if (obj->keyToNode[key].key != 0) {
        obj->keyToNode[key].value = value;
        updateFrequency(obj, key);
    } else {
        if (obj->size == obj->capacity) {
            for (int i = 1; i <= obj->capacity; i++) {
                if (obj->frequencyCount[i] > 0) {
                    ListNode* node = obj->frequencyList[i];
                    while (node && node->node->key != 0) {
                        node = node->next;
                    }
                    if (node) {
                        obj->keyToNode[node->node->key].key = 0;
                        obj->frequencyCount[i]--;
                        obj->size--;
                        break;
                    }
                }
            }
        }
        obj->keyToNode[key].key = key;
        obj->keyToNode[key].value = value;
        obj->keyToFrequency[key] = 1;
        ListNode* newNode = (ListNode*)malloc(sizeof(ListNode));
        newNode->node = &obj->keyToNode[key];
        newNode->next = obj->frequencyList[1];
        obj->frequencyList[1] = newNode;
        obj->frequencyCount[1]++;
        obj->size++;
        obj->minFrequency = 1;
    }
}