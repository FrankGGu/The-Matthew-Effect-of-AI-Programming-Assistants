int countIncremovableSubarrays(int* arr, int arrSize) {
    int left = 0, right = arrSize - 1;
    while (left < arrSize - 1 && arr[left] <= arr[left + 1]) {
        left++;
    }
    while (right > 0 && arr[right] >= arr[right - 1]) {
        right--;
    }
    if (left >= right) return arrSize;

    int result = (left + 1) + (arrSize - right);

    int maxLeft = arr[left], minRight = arr[right];
    for (int i = left; i >= 0; i--) {
        if (arr[i] > minRight) break;
        result++;
    }
    for (int i = right; i < arrSize; i++) {
        if (arr[i] < maxLeft) break;
        result++;
    }

    return result;
}