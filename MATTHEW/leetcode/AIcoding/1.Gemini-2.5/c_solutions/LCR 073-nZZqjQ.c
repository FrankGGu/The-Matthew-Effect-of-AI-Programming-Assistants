int minEatingSpeed(int* piles, int pilesSize, int h) {
    int low = 1;
    int high = 0; 
    for (int i = 0; i < pilesSize; i++) {
        if (piles[i] > high) {
            high = piles[i];
        }
    }

    int ans = high; 

    while (low <= high) {
        int mid = low + (high - low) / 2;
        long long hours_needed = 0;
        for (int i = 0; i < pilesSize; i++) {
            hours_needed += (long long)(piles[i] + mid - 1) / mid;
            if (hours_needed > h) {
                break; 
            }
        }

        if (hours_needed <= h) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}