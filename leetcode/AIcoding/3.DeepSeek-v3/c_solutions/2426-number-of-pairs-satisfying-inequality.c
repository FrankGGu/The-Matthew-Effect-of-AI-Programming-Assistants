long long numberOfPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int diff) {
    int n = nums1Size;
    int* arr = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = nums1[i] - nums2[i];
    }

    long long count = 0;
    int* temp = (int*)malloc(n * sizeof(int));

    void mergeSort(int left, int right) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(left, mid);
        mergeSort(mid + 1, right);

        int i = left, j = mid + 1;
        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j] + diff) {
                count += (right - j + 1);
                i++;
            } else {
                j++;
            }
        }

        i = left, j = mid + 1;
        int k = left;
        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
            }
        }
        while (i <= mid) temp[k++] = arr[i++];
        while (j <= right) temp[k++] = arr[j++];
        for (int p = left; p <= right; p++) arr[p] = temp[p];
    }

    mergeSort(0, n - 1);
    free(arr);
    free(temp);
    return count;
}