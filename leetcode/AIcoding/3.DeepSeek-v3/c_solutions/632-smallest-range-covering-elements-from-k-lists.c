typedef struct {
    int val;
    int row;
    int col;
} Element;

int compare(const void* a, const void* b) {
    return ((Element*)a)->val - ((Element*)b)->val;
}

int* smallestRange(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    Element* elements = malloc(100000 * sizeof(Element));
    int totalElements = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            elements[totalElements].val = nums[i][j];
            elements[totalElements].row = i;
            elements[totalElements].col = j;
            totalElements++;
        }
    }

    qsort(elements, totalElements, sizeof(Element), compare);

    int* count = calloc(numsSize, sizeof(int));
    int covered = 0;
    int left = 0;
    int minRange = INT_MAX;
    int* result = malloc(2 * sizeof(int));

    for (int right = 0; right < totalElements; right++) {
        if (count[elements[right].row] == 0) {
            covered++;
        }
        count[elements[right].row]++;

        while (covered == numsSize) {
            int currentRange = elements[right].val - elements[left].val;
            if (currentRange < minRange) {
                minRange = currentRange;
                result[0] = elements[left].val;
                result[1] = elements[right].val;
            }

            count[elements[left].row]--;
            if (count[elements[left].row] == 0) {
                covered--;
            }
            left++;
        }
    }

    free(elements);
    free(count);
    *returnSize = 2;
    return result;
}