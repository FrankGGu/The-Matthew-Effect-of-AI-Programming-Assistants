/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

typedef struct {
    int val;
    int index;
} Element;

int* countSmaller(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    if (numsSize == 0) return NULL;

    int* counts = (int*)calloc(numsSize, sizeof(int));
    Element* elements = (Element*)malloc(numsSize * sizeof(Element));
    Element* temp = (Element*)malloc(numsSize * sizeof(Element));

    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].index = i;
    }

    mergeSort(elements, 0, numsSize - 1, temp, counts);

    free(elements);
    free(temp);
    return counts;
}

void mergeSort(Element* elements, int left, int right, Element* temp, int* counts) {
    if (left >= right) return;

    int mid = left + (right - left) / 2;
    mergeSort(elements, left, mid, temp, counts);
    mergeSort(elements, mid + 1, right, temp, counts);

    merge(elements, left, mid, right, temp, counts);
}

void merge(Element* elements, int left, int mid, int right, Element* temp, int* counts) {
    int i = left;
    int j = mid + 1;
    int k = left;
    int rightCount = 0;

    while (i <= mid && j <= right) {
        if (elements[i].val > elements[j].val) {
            rightCount++;
            temp[k++] = elements[j++];
        } else {
            counts[elements[i].index] += rightCount;
            temp[k++] = elements[i++];
        }
    }

    while (i <= mid) {
        counts[elements[i].index] += rightCount;
        temp[k++] = elements[i++];
    }

    while (j <= right) {
        temp[k++] = elements[j++];
    }

    for (int idx = left; idx <= right; idx++) {
        elements[idx] = temp[idx];
    }
}