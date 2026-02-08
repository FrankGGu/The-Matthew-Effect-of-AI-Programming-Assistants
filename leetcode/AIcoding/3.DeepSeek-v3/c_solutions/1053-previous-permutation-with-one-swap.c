/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* prevPermOpt1(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    int* result = malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = arr[i];
    }

    int i = arrSize - 2;
    while (i >= 0 && arr[i] <= arr[i + 1]) {
        i--;
    }

    if (i < 0) {
        return result;
    }

    int j = arrSize - 1;
    while (arr[j] >= arr[i] || (j > 0 && arr[j] == arr[j - 1])) {
        j--;
    }

    int temp = result[i];
    result[i] = result[j];
    result[j] = temp;

    return result;
}