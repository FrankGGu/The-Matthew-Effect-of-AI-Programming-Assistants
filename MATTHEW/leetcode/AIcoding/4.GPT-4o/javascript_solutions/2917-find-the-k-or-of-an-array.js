function findKthBit(n, k) {
    if (k === 1) return '0';
    const len = (1 << n) - 1;
    const mid = len >> 1;

    if (k === mid + 1) return '1';
    if (k < mid + 1) return findKthBit(n - 1, k);
    return (findKthBit(n - 1, len - k + 1) === '0' ? '1' : '0');
}