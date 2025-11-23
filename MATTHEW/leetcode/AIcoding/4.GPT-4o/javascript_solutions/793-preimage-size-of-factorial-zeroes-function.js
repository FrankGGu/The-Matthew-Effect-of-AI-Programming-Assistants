var preimageSizeFZF = function(K) {
    const countZeros = (n) => {
        let count = 0;
        while (n > 0) {
            n = Math.floor(n / 5);
            count += n;
        }
        return count;
    };

    let low = 0, high = 5 * (K + 1), result = 0;
    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        const zeros = countZeros(mid);
        if (zeros < K) {
            low = mid + 1;
        } else if (zeros > K) {
            high = mid - 1;
        } else {
            result = 5; // Found one range of 5 numbers
            break;
        }
    }

    return result;
};