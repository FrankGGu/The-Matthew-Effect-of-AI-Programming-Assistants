typedef struct {
    int val;
    int idx;
} Element;

int cmp(const void* a, const void* b) {
    Element* e1 = (Element*)a;
    Element* e2 = (Element*)b;
    if (e1->val == e2->val) {
        return e1->idx - e2->idx;
    }
    return e1->val - e2->val;
}

long long findScore(int* nums, int numsSize) {
    Element* elements = (Element*)malloc(numsSize * sizeof(Element));
    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].idx = i;
    }

    qsort(elements, numsSize, sizeof(Element), cmp);

    int* marked = (int*)calloc(numsSize, sizeof(int));
    long long score = 0;

    for (int i = 0; i < numsSize; i++) {
        int idx = elements[i].idx;
        if (!marked[idx]) {
            score += elements[i].val;
            marked[idx] = 1;
            if (idx > 0) marked[idx - 1] = 1;
            if (idx < numsSize - 1) marked[idx + 1] = 1;
        }
    }

    free(elements);
    free(marked);
    return score;
}