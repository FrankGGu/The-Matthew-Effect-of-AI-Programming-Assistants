int ringGameChallenge(long long* challenge, int challengeSize) {
    long long target = 0;
    for (int i = 0; i < challengeSize; i++) {
        target |= challenge[i];
    }

    long long left = 1, right = target;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        if (canComplete(challenge, challengeSize, mid, target)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}

bool canComplete(long long* challenge, int n, long long initial, long long target) {
    long long current = initial;
    for (int start = 0; start < n; start++) {
        int i = start;
        long long cur = current;
        do {
            if (cur < challenge[i]) {
                break;
            }
            cur |= challenge[i];
            i = (i + 1) % n;
            if (cur == target) {
                return true;
            }
        } while (i != start);
    }
    return false;
}