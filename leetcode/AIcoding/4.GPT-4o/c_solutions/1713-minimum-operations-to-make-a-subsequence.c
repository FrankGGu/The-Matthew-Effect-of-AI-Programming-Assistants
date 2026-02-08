int minOperations(int* target, int targetSize, int* arr, int arrSize) {
    int pos[1001] = {0};
    for (int i = 0; i < targetSize; i++) {
        pos[target[i]] = i + 1;
    }

    int lis[1001] = {0};
    int length = 0;

    for (int i = 0; i < arrSize; i++) {
        if (pos[arr[i]]) {
            int index = pos[arr[i]] - 1;
            int left = 0, right = length;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (lis[mid] < index) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            lis[left] = index;
            if (left == length) {
                length++;
            }
        }
    }

    return targetSize - length;
}