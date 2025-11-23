int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

long long minimumTime(int* spells, int spellsSize, long long success) {
    long long left = 1, right = 1e18;
    long long ans = right;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long total = 0;

        for (int i = 0; i < spellsSize; i++) {
            total += mid / spells[i];
            if (total >= success) {
                break;
            }
        }

        if (total >= success) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}