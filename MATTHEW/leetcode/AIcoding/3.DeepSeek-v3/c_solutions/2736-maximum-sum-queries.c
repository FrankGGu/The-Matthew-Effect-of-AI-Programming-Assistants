typedef struct {
    int x;
    int y;
} Pair;

typedef struct {
    int val;
    int idx;
} Query;

typedef struct {
    int x;
    int y;
    int sum;
} StackNode;

int cmpPair(const void* a, const void* b) {
    Pair* pa = (Pair*)a;
    Pair* pb = (Pair*)b;
    if (pa->x == pb->x) {
        return pb->y - pa->y;
    }
    return pb->x - pa->x;
}

int cmpQuery(const void* a, const void* b) {
    Query* qa = (Query*)a;
    Query* qb = (Query*)b;
    return qb->val - qa->val;
}

int* maximumSumQueries(int* nums1, int nums1Size, int* nums2, int nums2Size, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    Pair* pairs = (Pair*)malloc(nums1Size * sizeof(Pair));
    for (int i = 0; i < nums1Size; i++) {
        pairs[i].x = nums1[i];
        pairs[i].y = nums2[i];
    }
    qsort(pairs, nums1Size, sizeof(Pair), cmpPair);

    Query* sortedQueries = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].val = queries[i][0];
        sortedQueries[i].idx = i;
    }
    qsort(sortedQueries, queriesSize, sizeof(Query), cmpQuery);

    int* res = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        res[i] = -1;
    }

    StackNode* stack = (StackNode*)malloc(nums1Size * sizeof(StackNode));
    int stackSize = 0;

    int j = 0;
    for (int i = 0; i < queriesSize; i++) {
        int x = sortedQueries[i].val;
        int idx = sortedQueries[i].idx;

        while (j < nums1Size && pairs[j].x >= x) {
            int curX = pairs[j].x;
            int curY = pairs[j].y;
            int curSum = curX + curY;

            while (stackSize > 0 && stack[stackSize - 1].y <= curY) {
                if (stack[stackSize - 1].sum >= curSum) {
                    break;
                }
                stackSize--;
            }

            if (stackSize == 0 || stack[stackSize - 1].sum < curSum) {
                stack[stackSize].x = curX;
                stack[stackSize].y = curY;
                stack[stackSize].sum = curSum;
                stackSize++;
            }
            j++;
        }

        if (stackSize == 0) {
            res[idx] = -1;
            continue;
        }

        int left = 0, right = stackSize - 1;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (stack[mid].y >= queries[idx][1]) {
                ans = stack[mid].sum;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        res[idx] = ans;
    }

    free(pairs);
    free(sortedQueries);
    free(stack);

    *returnSize = queriesSize;
    return res;
}