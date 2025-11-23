var preimageSize = function(k) {
    const countTrailingZeroes = (n) => {
        let count = 0;
        while (n > 0) {
            n = Math.floor(n / 5);
            count += n;
        }
        return count;
    }

    const search = (target) => {
        let low = 0;
        let high = 5 * target;
        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let zeroes = countTrailingZeroes(mid);
            if (zeroes < target) {
                low = mid + 1;
            } else if (zeroes > target) {
                high = mid - 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    return search(k + 1) - search(k);
};