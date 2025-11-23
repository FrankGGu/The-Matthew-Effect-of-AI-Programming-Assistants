int maxDistinctPrimes(int* nums, int numsSize) {
    int count = 0;
    int* visited = (int*)calloc(100001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num < 2) continue;
        int isPrime = 1;
        for (int j = 2; j * j <= num; j++) {
            if (num % j == 0) {
                isPrime = 0;
                break;
            }
        }
        if (isPrime && !visited[num]) {
            visited[num] = 1;
            count++;
        }
    }
    free(visited);
    return count;
}