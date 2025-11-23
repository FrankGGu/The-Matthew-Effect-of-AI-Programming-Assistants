int minSwaps(int* nums, int numsSize) {
    int* digitSum = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        digitSum[i] = 0;
        int n = nums[i];
        while (n > 0) {
            digitSum[i] += n % 10;
            n /= 10;
        }
    }

    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (digitSum[indices[i]] > digitSum[indices[j]] || 
                (digitSum[indices[i]] == digitSum[indices[j]] && nums[indices[i]] > nums[indices[j]])) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    int* visited = (int*)calloc(numsSize, sizeof(int));
    int swaps = 0;

    for (int i = 0; i < numsSize; i++) {
        if (visited[i] || indices[i] == i) {
            continue;
        }

        int cycle_size = 0;
        int j = i;
        while (!visited[j]) {
            visited[j] = 1;
            j = indices[j];
            cycle_size++;
        }

        if (cycle_size > 0) {
            swaps += (cycle_size - 1);
        }
    }

    free(digitSum);
    free(indices);
    free(visited);
    return swaps;
}