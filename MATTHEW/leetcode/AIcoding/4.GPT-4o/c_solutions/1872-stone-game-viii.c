int stoneGameVIII(int* stones, int stonesSize) {
    int max_sum = stones[0], prefix_sum = stones[0];
    for (int i = 1; i < stonesSize; i++) {
        prefix_sum += stones[i];
    }
    int res = max_sum;
    for (int i = 1; i < stonesSize; i++) {
        max_sum = (max_sum > prefix_sum - stones[i]) ? max_sum : (prefix_sum - stones[i]);
        res = (res > max_sum) ? res : max_sum;
        prefix_sum -= stones[i];
    }
    return res;
}