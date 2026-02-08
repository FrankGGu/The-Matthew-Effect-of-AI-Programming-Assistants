var findKthNumber = function(n, k) {
    let curr = 1;
    k--;
    while (k > 0) {
        let steps = 0;
        let first = curr;
        let last = curr + 1;
        while (first <= n) {
            steps += Math.min(n + 1, last) - first;
            first *= 10;
            last *= 10;
        }
        if (steps <= k) {
            k -= steps;
            curr++;
        } else {
            curr *= 10;
            k--;
        }
    }
    return curr;
};