typedef struct {
    int* combination;
    int n;
    int k;
    int index;
    int count;
    int* nums;
} CombinationIterator;

void backtrack(CombinationIterator* obj, int start, int depth) {
    if (depth == obj->k) {
        obj->count++;
        return;
    }
    for (int i = start; i <= obj->n - (obj->k - depth); i++) {
        obj->combination[depth] = obj->nums[i];
        backtrack(obj, i + 1, depth + 1);
    }
}

CombinationIterator* combinationIteratorCreate(int n, int k) {
    CombinationIterator* obj = malloc(sizeof(CombinationIterator));
    obj->n = n;
    obj->k = k;
    obj->index = 0;
    obj->count = 0;
    obj->combination = malloc(k * sizeof(int));
    obj->nums = malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; i++) {
        obj->nums[i] = i;
    }
    backtrack(obj, 1, 0);
    return obj;
}

char* combinationIteratorNext(CombinationIterator* obj) {
    if (obj->count == 0) return NULL;
    char* result = malloc((obj->k * 3 + 1) * sizeof(char));
    for (int i = 0; i < obj->k; i++) {
        sprintf(result + i * 3, "%d ", obj->combination[i]);
    }
    result[obj->k * 3 - 1] = '\0';
    obj->count--;
    obj->index++;
    return result;
}

bool combinationIteratorHasNext(CombinationIterator* obj) {
    return obj->count > 0;
}

void combinationIteratorFree(CombinationIterator* obj) {
    free(obj->combination);
    free(obj->nums);
    free(obj);
}