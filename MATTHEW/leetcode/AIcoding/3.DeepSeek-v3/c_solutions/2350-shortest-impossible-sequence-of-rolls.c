int shortestSequence(int* rolls, int rollsSize, int k) {
    int ans = 1;
    int seen = 0;

    for (int i = 0; i < rollsSize; i++) {
        seen |= 1 << (rolls[i] - 1);
        if (seen == (1 << k) - 1) {
            ans++;
            seen = 0;
        }
    }

    return ans;
}