int countWays(int* buildings, int buildingsSize) {
    long long count = 0, left = 0, right = 0;
    for (int i = 0; i < buildingsSize; i++) {
        if (buildings[i] == 1) left++;
    }
    for (int i = 0; i < buildingsSize; i++) {
        if (buildings[i] == 1) {
            right++;
            left--;
        } else if (buildings[i] == 0) {
            count += right * left;
        }
    }
    return count % 1000000007;
}