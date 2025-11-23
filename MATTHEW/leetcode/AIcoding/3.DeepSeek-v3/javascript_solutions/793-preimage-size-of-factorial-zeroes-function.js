var preimageSizeFZF = function(K) {
    const trailingZeroes = function(n) {
        let count = 0;
        while (n > 0) {
            n = Math.floor(n / 5);
            count += n;
        }
        return count;
    };

    let left = 0, right = 5 * (K + 1);
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let zeros = trailingZeroes(mid);
        if (zeros === K) {
            return 5;
        } else if (zeros < K) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return 0;
};