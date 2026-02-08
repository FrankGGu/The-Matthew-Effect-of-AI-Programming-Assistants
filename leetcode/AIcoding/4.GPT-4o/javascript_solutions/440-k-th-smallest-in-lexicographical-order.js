var findKthNumber = function(n, k) {
    let current = 1;
    k--;

    while (k > 0) {
        let steps = 0;
        let first = current;
        let last = current + 1;

        while (first <= n) {
            steps += Math.min(n + 1, last) - first;
            first *= 10;
            last *= 10;
        }

        if (steps <= k) {
            current++;
            k -= steps;
        } else {
            current *= 10;
            k--;
        }
    }

    return current;
};