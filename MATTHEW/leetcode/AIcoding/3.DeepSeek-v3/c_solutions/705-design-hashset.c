typedef struct Node {
    int key;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} MyHashSet;

MyHashSet* myHashSetCreate() {
    MyHashSet* obj = (MyHashSet*)malloc(sizeof(MyHashSet));
    obj->size = 10000;
    obj->buckets = (Node**)calloc(obj->size, sizeof(Node*));
    return obj;
}

int hash(MyHashSet* obj, int key) {
    return key % obj->size;
}

void myHashSetAdd(MyHashSet* obj, int key) {
    int index = hash(obj, key);
    Node* curr = obj->buckets[index];
    while (curr) {
        if (curr->key == key) return;
        curr = curr->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->next = obj->buckets[index];
    obj->buckets[index] = newNode;
}

void myHashSetRemove(MyHashSet* obj, int key) {
    int index = hash(obj, key);
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

bool myHashSetContains(MyHashSet* obj, int key) {
    int index = hash(obj, key);
    Node* curr = obj->buckets[index];
    while (curr) {
        if (curr->key == key) return true;
        curr = curr->next;
    }
    return false;
}

void myHashSetFree(MyHashSet* obj) {
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