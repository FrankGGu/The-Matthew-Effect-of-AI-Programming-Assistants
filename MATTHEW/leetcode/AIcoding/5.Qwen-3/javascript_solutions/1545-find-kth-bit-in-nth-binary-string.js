function findKthBit(n, k) {
    if (n === 1) return "0";
    let len = 1 << (n - 1);
    if (k === len) return "1";
    if (k < len) {
        return findKthBit(n - 1, k);
    } else {
        return findKthBit(n - 1, len - (k - len)) === "0" ? "1" : "0";
    }
}