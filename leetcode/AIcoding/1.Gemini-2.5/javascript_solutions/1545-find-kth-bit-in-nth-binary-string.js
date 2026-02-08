var findKthBit = function(n, k) {
    function invert(char) {
        return char === '0' ? '1' : '0';
    }

    if (n === 1) {
        return '0';
    }

    const mid = Math.pow(2, n - 1);

    if (k === mid) {
        return '1';
    } else if (k < mid) {
        return findKthBit(n - 1, k);
    } else {
        const newK = Math.pow(2, n) - k;
        return invert(findKthBit(n - 1, newK));
    }
};