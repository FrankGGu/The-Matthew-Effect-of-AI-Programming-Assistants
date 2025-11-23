int closestToTarget(int* arr, int arrSize, int target) {
    int ans = abs(arr[0] - target);
    int* valid = (int*)malloc(arrSize * sizeof(int));
    int size = 0;
    valid[size++] = arr[0];

    for (int i = 1; i < arrSize; i++) {
        int* valid_new = (int*)malloc(arrSize * sizeof(int));
        int new_size = 0;
        valid_new[new_size++] = arr[i];
        ans = fmin(ans, abs(arr[i] - target));

        for (int j = 0; j < size; j++) {
            int val = valid[j] & arr[i];
            if (new_size == 0 || val != valid_new[new_size - 1]) {
                valid_new[new_size++] = val;
                ans = fmin(ans, abs(val - target));
            }
        }
        free(valid);
        valid = valid_new;
        size = new_size;
    }
    free(valid);
    return ans;
}