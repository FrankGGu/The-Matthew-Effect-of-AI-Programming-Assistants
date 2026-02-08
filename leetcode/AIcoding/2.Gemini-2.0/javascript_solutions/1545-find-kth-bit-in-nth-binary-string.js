var findKthBit = function(n, k) {
    if (n === 1) {
        return "0";
    }
    const len = Math.pow(2, n) - 1;
    const mid = Math.floor(len / 2) + 1;

    if (k === mid) {
        return "1";
    } else if (k < mid) {
        return findKthBit(n - 1, k);
    } else {
        const bit = findKthBit(n - 1, len - k + 1);
        return bit === "0" ? "1" : "0";
    }
};