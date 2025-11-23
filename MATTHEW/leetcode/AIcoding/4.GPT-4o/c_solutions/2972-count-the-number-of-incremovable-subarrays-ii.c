int countIncremovableSubarrays(int* arr, int arrSize) {
    if (arrSize == 0) return 0;

    int left = 0, right = arrSize - 1;
    while (left < arrSize - 1 && arr[left] <= arr[left + 1]) left++;
    while (right > 0 && arr[right] >= arr[right - 1]) right--;

    if (left == arrSize - 1) return arrSize;

    int res = left + 1 + (arrSize - right);
    for (int i = left + 1; i <= right; i++) {
        if (arr[i] < arr[left] || arr[i] > arr[right]) {
            res = fmax(res, i - left + (arrSize - right));
        }
    }

    return res;
}