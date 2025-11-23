int maxJump(int* stones, int stonesSize) {
    if (stonesSize < 2) return 0;
    int maxJump = 0;
    for (int i = 1; i < stonesSize; i++) {
        int jump = stones[i] - stones[i - 1];
        if (jump > maxJump) {
            maxJump = jump;
        }
    }
    return maxJump;
}