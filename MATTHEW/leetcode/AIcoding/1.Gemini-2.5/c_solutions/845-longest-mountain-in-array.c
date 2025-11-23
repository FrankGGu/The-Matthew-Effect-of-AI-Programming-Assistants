int longestMountain(int* arr, int arrSize) {
    if (arrSize < 3) {
        return 0;
    }

    int maxLength = 0;
    int base = 0;

    while (base < arrSize) {
        int j = base;

        if (j + 1 < arrSize && arr[j] < arr[j+1]) {
            while (j + 1 < arrSize && arr[j] < arr[j+1]) {
                j++;
            }

            if (j + 1 < arrSize && arr[j] > arr[j+1]) {
                while (j + 1 < arrSize && arr[j] > arr[j+1]) {
                    j++;
                }
                maxLength = (maxLength > (j - base + 1)) ? maxLength : (j - base + 1);
            }
        }

        base = (j == base) ? base + 1 : j;
    }

    return maxLength;
}