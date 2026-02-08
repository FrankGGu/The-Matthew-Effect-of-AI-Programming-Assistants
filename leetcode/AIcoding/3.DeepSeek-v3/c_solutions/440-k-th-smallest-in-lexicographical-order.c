int findKthNumber(int n, int k) {
    long long curr = 1;
    k--;

    while (k > 0) {
        long long steps = 0;
        long long first = curr;
        long long last = curr + 1;

        while (first <= n) {
            steps += (n + 1 < last ? n + 1 : last) - first;
            first *= 10;
            last *= 10;
        }

        if (steps <= k) {
            curr++;
            k -= steps;
        } else {
            curr *= 10;
            k--;
        }
    }

    return curr;
}