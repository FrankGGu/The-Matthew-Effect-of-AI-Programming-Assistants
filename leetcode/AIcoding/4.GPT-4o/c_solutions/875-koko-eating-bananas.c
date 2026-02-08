int canEatAllBananas(int* piles, int pilesSize, int speed, int h) {
    long long hours = 0;
    for (int i = 0; i < pilesSize; i++) {
        hours += (piles[i] + speed - 1) / speed;
    }
    return hours <= h;
}

int minEatingSpeed(int* piles, int pilesSize, int h) {
    int left = 1, right = 1000000000, answer = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canEatAllBananas(piles, pilesSize, mid, h)) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
}