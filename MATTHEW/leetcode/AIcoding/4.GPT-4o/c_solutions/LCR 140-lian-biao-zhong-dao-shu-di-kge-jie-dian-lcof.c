int canComplete(int* difficulty, int* profit, int n, int day, int capacity) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        if (difficulty[i] <= day) {
            total = total > profit[i] ? total : profit[i];
        }
    }
    return total <= capacity;
}

int trainingPlan(int* difficulty, int* profit, int n, int capacity) {
    int maxDays = 0;
    for (int i = 0; i < n; i++) {
        if (difficulty[i] > maxDays) {
            maxDays = difficulty[i];
        }
    }

    int left = 1, right = maxDays, bestDay = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canComplete(difficulty, profit, n, mid, capacity)) {
            bestDay = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return bestDay;
}