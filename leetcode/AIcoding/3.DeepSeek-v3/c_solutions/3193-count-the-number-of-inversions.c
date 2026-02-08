int mergeAndCount(int* arr, int left, int mid, int right, int* temp) {
    int i = left;
    int j = mid + 1;
    int k = left;
    int inv_count = 0;

    while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            inv_count += (mid - i + 1);
        }
    }

    while (i <= mid) {
        temp[k++] = arr[i++];
    }

    while (j <= right) {
        temp[k++] = arr[j++];
    }

    for (i = left; i <= right; i++) {
        arr[i] = temp[i];
    }

    return inv_count;
}

int mergeSortAndCount(int* arr, int left, int right, int* temp) {
    int inv_count = 0;
    if (left < right) {
        int mid = left + (right - left) / 2;

        inv_count += mergeSortAndCount(arr, left, mid, temp);
        inv_count += mergeSortAndCount(arr, mid + 1, right, temp);
        inv_count += mergeAndCount(arr, left, mid, right, temp);
    }
    return inv_count;
}

int countInversions(int* arr, int n) {
    int* temp = (int*)malloc(n * sizeof(int));
    int result = mergeSortAndCount(arr, 0, n - 1, temp);
    free(temp);
    return result;
}