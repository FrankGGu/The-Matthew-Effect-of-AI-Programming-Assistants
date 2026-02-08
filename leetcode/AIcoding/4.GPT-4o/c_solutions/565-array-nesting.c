int arrayNesting(int* nums, int numsSize) {
    int maxSize = 0;
    int* visited = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (!visited[i]) {
            int count = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = 1;
                j = nums[j];
                count++;
            }
            if (count > maxSize) {
                maxSize = count;
            }
        }
    }

    free(visited);
    return maxSize;
}