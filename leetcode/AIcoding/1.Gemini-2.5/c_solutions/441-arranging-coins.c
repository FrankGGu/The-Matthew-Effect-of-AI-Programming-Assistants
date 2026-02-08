long long arrangeCoins(int n) {
    long long num = n;
    long long low = 0;
    long long high = num;
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long coinsNeeded = mid * (mid + 1) / 2;

        if (coinsNeeded <= num) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}