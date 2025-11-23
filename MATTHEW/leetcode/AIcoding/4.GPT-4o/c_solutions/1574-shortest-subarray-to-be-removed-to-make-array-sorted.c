int findLengthOfShortestSubarray(int* arr, int arrSize) {
    int left = 0, right = arrSize - 1;

    while (left + 1 < arrSize && arr[left] <= arr[left + 1]) {
        left++;
    }

    if (left == arrSize - 1) return 0;

    while (right > 0 && arr[right - 1] <= arr[right]) {
        right--;
    }

    int res = fmin(right, arrSize - left - 1);

    for (int i = 0; i <= left; i++) {
        while (right < arrSize && arr[i] > arr[right]) {
            right++;
        }
        res = fmin(res, right - i - 1);
    }

    return res;
}