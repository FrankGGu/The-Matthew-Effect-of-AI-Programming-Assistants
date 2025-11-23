int maxJump(int* stones, int stonesSize) {
    int res = stones[1] - stones[0];
    for (int i = 2; i < stonesSize; i++) {
        if (stones[i] - stones[i - 2] > res) {
            res = stones[i] - stones[i - 2];
        }
    }
    return res;
}