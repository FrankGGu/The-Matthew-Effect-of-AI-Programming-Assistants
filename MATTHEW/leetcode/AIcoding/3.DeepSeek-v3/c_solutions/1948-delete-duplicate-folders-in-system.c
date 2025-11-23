typedef struct TrieNode {
    char* name;
    struct TrieNode** children;
    int childrenSize;
    int childrenCapacity;
    char* serial;
    struct TrieNode* next; // for hash chaining
} TrieNode;

typedef struct {
    TrieNode** buckets;
    int bucketSize;
} HashMap;

typedef struct {
    char** paths;
    int pathsSize;
} Result;

#define BUCKET_SIZE 10007

unsigned int hash(char* str) {
    unsigned int hash = 0;
    while (*str) {
        hash = hash * 131 + *str++;
    }
    return hash;
}

TrieNode* createNode(char* name) {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->name = name;
    node->children = NULL;
    node->childrenSize = 0;
    node->childrenCapacity = 0;
    node->serial = NULL;
    node->next = NULL;
    return node;
}

void addChild(TrieNode* parent, TrieNode* child) {
    if (parent->childrenSize >= parent->childrenCapacity) {
        parent->childrenCapacity = parent->childrenCapacity == 0 ? 4 : parent->childrenCapacity * 2;
        parent->children = (TrieNode**)realloc(parent->children, parent->childrenCapacity * sizeof(TrieNode*));
    }
    parent->children[parent->childrenSize++] = child;
}

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->bucketSize = BUCKET_SIZE;
    map->buckets = (TrieNode**)calloc(BUCKET_SIZE, sizeof(TrieNode*));
    return map;
}

void addToHashMap(HashMap* map, char* key, TrieNode* node) {
    unsigned int h = hash(key) % map->bucketSize;
    node->next = map->buckets[h];
    map->buckets[h] = node;
}

TrieNode* findInHashMap(HashMap* map, char* key) {
    unsigned int h = hash(key) % map->bucketSize;
    TrieNode* node = map->buckets[h];
    while (node) {
        if (strcmp(node->serial, key) == 0) {
            return node;
        }
        node = node->next;
    }
    return NULL;
}

int compare(const void* a, const void* b) {
    TrieNode* nodeA = *(TrieNode**)a;
    TrieNode* nodeB = *(TrieNode**)b;
    return strcmp(nodeA->name, nodeB->name);
}

char* serialize(TrieNode* node, HashMap* map) {
    if (node->childrenSize == 0) {
        return strdup("");
    }

    qsort(node->children, node->childrenSize, sizeof(TrieNode*), compare);

    char* result = (char*)malloc(1);
    result[0] = '\0';

    for (int i = 0; i < node->childrenSize; i++) {
        char* childSerial = serialize(node->children[i], map);
        char* temp = (char*)malloc(strlen(node->children[i]->name) + strlen(childSerial) + 4);
        sprintf(temp, "(%s%s)", node->children[i]->name, childSerial);

        char* newResult = (char*)malloc(strlen(result) + strlen(temp) + 1);
        strcpy(newResult, result);
        strcat(newResult, temp);

        free(result);
        free(temp);
        free(childSerial);
        result = newResult;
    }

    node->serial = result;

    if (strlen(result) > 0) {
        TrieNode* existing = findInHashMap(map, result);
        if (existing) {
            existing->serial = "*";
            node->serial = "*";
        } else {
            addToHashMap(map, result, node);
        }
    }

    return strdup(result);
}

void collectPaths(TrieNode* node, char** currentPath, int depth, Result* result) {
    if (node->serial && strcmp(node->serial, "*") == 0) {
        return;
    }

    if (depth > 0) {
        char** path = (char**)malloc(depth * sizeof(char*));
        for (int i = 0; i < depth; i++) {
            path[i] = currentPath[i];
        }
        result->paths[result->pathsSize] = path;
        result->pathsSize++;
    }

    for (int i = 0; i < node->childrenSize; i++) {
        currentPath[depth] = node->children[i]->name;
        collectPaths(node->children[i], currentPath, depth + 1, result);
    }
}

char*** deleteDuplicateFolder(char*** paths, int pathsSize, int* pathsColSize, int* returnSize, int** returnColumnSizes) {
    TrieNode* root = createNode("");

    for (int i = 0; i < pathsSize; i++) {
        TrieNode* current = root;
        for (int j = 0; j < pathsColSize[i]; j++) {
            TrieNode* child = NULL;
            for (int k = 0; k < current->childrenSize; k++) {
                if (strcmp(current->children[k]->name, paths[i][j]) == 0) {
                    child = current->children[k];
                    break;
                }
            }
            if (!child) {
                child = createNode(strdup(paths[i][j]));
                addChild(current, child);
            }
            current = child;
        }
    }

    HashMap* map = createHashMap();
    serialize(root, map);

    Result* result = (Result*)malloc(sizeof(Result));
    result->paths = (char**)malloc(10000 * sizeof(char*));
    result->pathsSize = 0;

    char** currentPath = (char**)malloc(100 * sizeof(char*));
    collectPaths(root, currentPath, 0, result);

    *returnSize = result->pathsSize;
    *returnColumnSizes = (int*)malloc(result->pathsSize * sizeof(int));
    char*** answer = (char***)malloc(result->pathsSize * sizeof(char**));

    for (int i = 0; i < result->pathsSize; i++) {
        int depth = 0;
        while (result->paths[i][depth] != NULL) depth++;
        (*returnColumnSizes)[i] = depth;
        answer[i] = (char**)malloc(depth * sizeof(char*));
        for (int j = 0; j < depth; j++) {
            answer[i][j] = result->paths[i][j];
        }
        free(result->paths[i]);
    }

    free(result->paths);
    free(result);
    free(currentPath);

    // Free trie and hashmap (simplified for LeetCode)

    return answer;
}