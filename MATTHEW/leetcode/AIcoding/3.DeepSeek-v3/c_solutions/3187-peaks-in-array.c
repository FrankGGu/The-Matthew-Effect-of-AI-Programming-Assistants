typedef struct {
    int* arr;
    int size;
} FenwTree;

FenwTree* createFenwTree(int n) {
    FenwTree* tree = (FenwTree*)malloc(sizeof(FenwTree));
    tree->arr = (int*)calloc(n + 1, sizeof(int));
    tree->size = n;
    return tree;
}

void update(FenwTree* tree, int index, int delta) {
    while (index <= tree->size) {
        tree->arr[index] += delta;
        index += index & -index;
    }
}

int query(FenwTree* tree, int index) {
    int sum = 0;
    while (index > 0) {
        sum += tree->arr[index];
        index -= index & -index;
    }
    return sum;
}

int rangeQuery(FenwTree* tree, int l, int r) {
    return query(tree, r) - query(tree, l - 1);
}

int* countOfPeaks(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = 0;

    FenwTree* tree = createFenwTree(numsSize);

    for (int i = 1; i < numsSize - 1; i++) {
        if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
            update(tree, i + 1, 1);
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        if (queries[i][0] == 1) {
            int l = queries[i][1] + 1;
            int r = queries[i][2] + 1;
            if (r - l < 2) {
                result[(*returnSize)++] = 0;
            } else {
                result[(*returnSize)++] = rangeQuery(tree, l + 1, r - 1);
            }
        } else {
            int index = queries[i][1];
            int val = queries[i][2];
            nums[index] = val;

            for (int j = index - 1; j <= index + 1; j++) {
                if (j > 0 && j < numsSize - 1) {
                    int old = rangeQuery(tree, j + 1, j + 1);
                    int new = (nums[j] > nums[j - 1] && nums[j] > nums[j + 1]) ? 1 : 0;
                    if (old != new) {
                        update(tree, j + 1, new - old);
                    }
                }
            }
        }
    }

    free(tree->arr);
    free(tree);

    return result;
}