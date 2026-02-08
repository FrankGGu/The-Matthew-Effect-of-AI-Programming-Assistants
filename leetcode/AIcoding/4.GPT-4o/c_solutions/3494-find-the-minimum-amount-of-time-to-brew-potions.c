int minTimeToBrew(int* potions, int potionsSize, int totalTime) {
    long long sumTime = 0;
    for (int i = 0; i < potionsSize; i++) {
        sumTime += potions[i];
    }
    if (sumTime <= totalTime) return 0;

    long long left = 1, right = 1e18, ans = -1;
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long timeSpent = 0;
        for (int i = 0; i < potionsSize; i++) {
            timeSpent += (mid / potions[i]);
        }
        if (timeSpent >= potionsSize) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}