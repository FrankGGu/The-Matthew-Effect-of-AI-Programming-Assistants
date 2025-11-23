typedef struct Node {
    int key;
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} MyHashMap;

MyHashMap* myHashMapCreate() {
    MyHashMap* obj = (MyHashMap*)malloc(sizeof(MyHashMap));
    obj->size = 10000;
    obj->buckets = (Node**)calloc(obj->size, sizeof(Node*));
    return obj;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    int index = key % obj->size;
    Node* curr = obj->buckets[index];
    while (curr) {
        if (curr->key == key) {
            curr->val = value;
            return;
        }
        curr = curr->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->val = value;
    newNode->next = obj->buckets[index];
    obj->buckets[index] = newNode;
}

int myHashMapGet(MyHashMap* obj, int key) {
    int index = key % obj->size;
    Node* curr = obj->buckets[index];
    while (curr) {
        if (curr->key == key) {
            return curr->val;
        }
        curr = curr->next;
    }
    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    int index = key % obj->size;
    Node* curr = obj->buckets[index];
    Node* prev = NULL;
    while (curr) {
        if (curr->key == key) {
            if (prev) {
                prev->next = curr->next;
            } else {
                obj->buckets[index] = curr->next;
            }
            free(curr);
            return;
        }
        prev = curr;
        curr = curr->next;
    }
}

void myHashMapFree(MyHashMap* obj) {
    for (int i = 0; i < obj->size; i++) {
        Node* curr = obj->buckets[i];
        while (curr) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(obj->buckets);
    free(obj);
}