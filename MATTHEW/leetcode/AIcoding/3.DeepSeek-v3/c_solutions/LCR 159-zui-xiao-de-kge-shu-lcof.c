int* inventoryManagement(int* stock, int stockSize, int cnt, int* returnSize) {
    *returnSize = cnt;
    if (cnt == 0) return NULL;

    int left = 0, right = stockSize - 1;
    while (left <= right) {
        int pivot = partition(stock, left, right);
        if (pivot == cnt - 1) {
            break;
        } else if (pivot < cnt - 1) {
            left = pivot + 1;
        } else {
            right = pivot - 1;
        }
    }

    int* result = (int*)malloc(cnt * sizeof(int));
    for (int i = 0; i < cnt; i++) {
        result[i] = stock[i];
    }
    return result;
}

int partition(int* arr, int left, int right) {
    int pivot = arr[left];
    int i = left, j = right;
    while (i < j) {
        while (i < j && arr[j] >= pivot) j--;
        arr[i] = arr[j];
        while (i < j && arr[i] <= pivot) i++;
        arr[j] = arr[i];
    }
    arr[i] = pivot;
    return i;
}