int longestMountain(int* arr, int arrSize) {
    int maxLen = 0;
    int i = 1;

    while (i < arrSize - 1) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            int left = i - 1;
            while (left > 0 && arr[left] > arr[left - 1]) {
                left--;
            }

            int right = i + 1;
            while (right < arrSize - 1 && arr[right] > arr[right + 1]) {
                right++;
            }

            int length = right - left + 1;
            if (length > maxLen) {
                maxLen = length;
            }

            i = right;
        } else {
            i++;
        }
    }

    return maxLen;
}