typedef struct {
    char key;
    char value;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} HashMap;

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->buckets = (Node**)calloc(size, sizeof(Node*));
    return map;
}

void put(HashMap* map, char key, char value) {
    int index = key % map->size;
    Node* node = map->buckets[index];
    while (node != NULL) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
}

char get(HashMap* map, char key) {
    int index = key % map->size;
    Node* node = map->buckets[index];
    while (node != NULL) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return '\0';
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        Node* node = map->buckets[i];
        while (node != NULL) {
            Node* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

bool matchReplacement(char* s, char* sub, char** mappings, int mappingsSize, int* mappingsColSize) {
    HashMap* map = createHashMap(256);

    for (int i = 0; i < mappingsSize; i++) {
        char oldChar = mappings[i][0];
        char newChar = mappings[i][1];
        put(map, oldChar, newChar);
    }

    int sLen = strlen(s);
    int subLen = strlen(sub);

    for (int i = 0; i <= sLen - subLen; i++) {
        bool match = true;
        for (int j = 0; j < subLen; j++) {
            char sChar = s[i + j];
            char subChar = sub[j];

            if (sChar == subChar) {
                continue;
            }

            char replacement = get(map, subChar);
            if (replacement == sChar) {
                continue;
            }

            match = false;
            break;
        }
        if (match) {
            freeHashMap(map);
            return true;
        }
    }

    freeHashMap(map);
    return false;
}