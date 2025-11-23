typedef struct {
    char *key;
    int count;
    struct Node *next;
} Node;

typedef struct {
    Node *head;
} List;

typedef struct {
    char *key;
    int val;
    UT_hash_handle hh;
} HashItem;

typedef struct {
    char *key;
    List *list;
    UT_hash_handle hh;
} PolyHashItem;

HashItem *hashFindItem(HashItem **obj, char *key) {
    HashItem *pEntry = NULL;
    HASH_FIND_STR(*obj, key, pEntry);
    return pEntry;
}

bool hashAddItem(HashItem **obj, char *key, int val) {
    if (hashFindItem(obj, key)) {
        return false;
    }
    HashItem *pEntry = (HashItem *)malloc(sizeof(HashItem));
    pEntry->key = key;
    pEntry->val = val;
    HASH_ADD_STR(*obj, key, pEntry);
    return true;
}

bool hashSetItem(HashItem **obj, char *key, int val) {
    HashItem *pEntry = hashFindItem(obj, key);
    if (!pEntry) {
        hashAddItem(obj, key, val);
    } else {
        pEntry->val = val;
    }
    return true;
}

int hashGetItem(HashItem **obj, char *key, int defaultVal) {
    HashItem *pEntry = hashFindItem(obj, key);
    if (!pEntry) {
        return defaultVal;
    }
    return pEntry->val;
}

void hashFree(HashItem **obj) {
    HashItem *curr = NULL, *tmp = NULL;
    HASH_ITER(hh, *obj, curr, tmp) {
        HASH_DEL(*obj, curr);
        free(curr);
    }
}

PolyHashItem *polyHashFindItem(PolyHashItem **obj, char *key) {
    PolyHashItem *pEntry = NULL;
    HASH_FIND_STR(*obj, key, pEntry);
    return pEntry;
}

bool polyHashAddItem(PolyHashItem **obj, char *key, List *list) {
    if (polyHashFindItem(obj, key)) {
        return false;
    }
    PolyHashItem *pEntry = (PolyHashItem *)malloc(sizeof(PolyHashItem));
    pEntry->key = key;
    pEntry->list = list;
    HASH_ADD_STR(*obj, key, pEntry);
    return true;
}

void polyHashFree(PolyHashItem **obj) {
    PolyHashItem *curr = NULL, *tmp = NULL;
    HASH_ITER(hh, *obj, curr, tmp) {
        HASH_DEL(*obj, curr);
        free(curr);
    }
}

List *createList() {
    List *obj = (List *)malloc(sizeof(List));
    obj->head = NULL;
    return obj;
}

void freeList(List *obj) {
    Node *curr = obj->head;
    while (curr) {
        Node *tmp = curr;
        curr = curr->next;
        free(tmp->key);
        free(tmp);
    }
    free(obj);
}

void listAdd(List *obj, char *key, int count) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->key = key;
    node->count = count;
    node->next = obj->head;
    obj->head = node;
}

int cmp(const void *a, const void *b) {
    Node *node1 = *(Node **)a;
    Node *node2 = *(Node **)b;
    int len1 = 0, len2 = 0;
    char *s1 = node1->key;
    char *s2 = node2->key;
    for (int i = 0; s1[i]; i++) {
        if (s1[i] == '*') len1++;
    }
    for (int i = 0; s2[i]; i++) {
        if (s2[i] == '*') len2++;
    }
    if (len1 != len2) return len2 - len1;
    return strcmp(s1, s2);
}

char **listToArray(List *obj, int *returnSize) {
    int n = 0;
    for (Node *curr = obj->head; curr; curr = curr->next) {
        if (curr->count != 0) n++;
    }
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }
    Node **nodes = (Node **)malloc(n * sizeof(Node *));
    int idx = 0;
    for (Node *curr = obj->head; curr; curr = curr->next) {
        if (curr->count != 0) {
            nodes[idx++] = curr;
        }
    }
    qsort(nodes, n, sizeof(Node *), cmp);
    char **ans = (char **)malloc(n * sizeof(char *));
    for (int i = 0; i < n; i++) {
        char *tmp = (char *)malloc(50);
        if (nodes[i]->count == 1) {
            sprintf(tmp, "%s", nodes[i]->key);
        } else {
            sprintf(tmp, "%d*%s", nodes[i]->count, nodes[i]->key);
        }
        ans[i] = tmp;
    }
    free(nodes);
    *returnSize = n;
    return ans;
}

List *combine(List *a, List *b, int sign) {
    HashItem *countMap = NULL;
    for (Node *curr = a->head; curr; curr = curr->next) {
        hashSetItem(&countMap, curr->key, curr->count);
    }
    for (Node *curr = b->head; curr; curr = curr->next) {
        int val = hashGetItem(&countMap, curr->key, 0);
        hashSetItem(&countMap, curr->key, val + sign * curr->count);
    }
    List *res = createList();
    HashItem *curr = NULL, *tmp = NULL;
    HASH_ITER(hh, countMap, curr, tmp) {
        if (curr->val != 0) {
            listAdd(res, curr->key, curr->val);
        }
    }
    hashFree(&countMap);
    return res;
}

List *multiply(List *a, List *b) {
    List *res = createList();
    for (Node *x = a->head; x; x = x->next) {
        for (Node *y = b->head; y; y = y->next) {
            char *key1 = x->key;
            char *key2 = y->key;
            int count = x->count * y->count;
            if (count == 0) continue;
            if (key1[0] == '\0' && key2[0] == '\0') {
                listAdd(res, "", count);
            } else if (key1[0] == '\0') {
                listAdd(res, key2, count);
            } else if (key2[0] == '\0') {
                listAdd(res, key1, count);
            } else {
                int len1 = strlen(key1), len2 = strlen(key2);
                char *newKey = (char *)malloc(len1 + len2 + 2);
                strcpy(newKey, key1);
                strcat(newKey, "*");
                strcat(newKey, key2);
                char **vars = (char **)malloc(10 * sizeof(char *));
                int n = 0;
                char *token = strtok(newKey, "*");
                while (token) {
                    vars[n++] = token;
                    token = strtok(NULL, "*");
                }
                qsort(vars, n, sizeof(char *), (int (*)(const void *, const void *))strcmp);
                char *sortedKey = (char *)malloc(len1 + len2 + 2);
                sortedKey[0] = '\0';
                for (int i = 0; i < n; i++) {
                    if (i > 0) strcat(sortedKey, "*");
                    strcat(sortedKey, vars[i]);
                }
                free(vars);
                free(newKey);
                listAdd(res, sortedKey, count);
            }
        }
    }
    HashItem *countMap = NULL;
    for (Node *curr = res->head; curr; curr = curr->next) {
        int val = hashGetItem(&countMap, curr->key, 0);
        hashSetItem(&countMap, curr->key, val + curr->count);
    }
    List *ans = createList();
    HashItem *curr = NULL, *tmp = NULL;
    HASH_ITER(hh, countMap, curr, tmp) {
        if (curr->val != 0) {
            listAdd(ans, curr->key, curr->val);
        }
    }
    hashFree(&countMap);
    freeList(res);
    return ans;
}

List *calculate(char *s, PolyHashItem **evalMap) {
    int n = strlen(s);
    List *stack[n];
    int top =