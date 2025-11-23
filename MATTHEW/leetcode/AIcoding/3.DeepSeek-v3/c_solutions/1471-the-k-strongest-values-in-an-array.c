/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    // Sort the array first
    for (int i = 0; i < arrSize - 1; i++) {
        for (int j = 0; j < arrSize - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    // Calculate median
    int median = arr[(arrSize - 1) / 2];

    // Create array of indices for two-pointer approach
    int* result = (int*)malloc(k * sizeof(int));
    int left = 0, right = arrSize - 1;
    int count = 0;

    while (count < k) {
        int leftStrength = abs(arr[left] - median);
        int rightStrength = abs(arr[right] - median);

        if (rightStrength > leftStrength) {
            result[count++] = arr[right--];
        } else if (leftStrength > rightStrength) {
            result[count++] = arr[left++];
        } else {
            if (arr[right] > arr[left]) {
                result[count++] = arr[right--];
            } else {
                result[count++] = arr[left++];
            }
        }
    }

    *returnSize = k;
    return result;
}