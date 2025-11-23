var findKthBit = function(n, k) {
    if (n === 1) {
        return "0";
    }
    let length = Math.pow(2, n) - 1;
    let mid = Math.floor(length / 2) + 1;
    if (k === mid) {
        return "1";
    } else if (k < mid) {
        return findKthBit(n - 1, k);
    } else {
        let bit = findKthBit(n - 1, length - k + 1);
        return bit === "0" ? "1" : "0";
    }
};