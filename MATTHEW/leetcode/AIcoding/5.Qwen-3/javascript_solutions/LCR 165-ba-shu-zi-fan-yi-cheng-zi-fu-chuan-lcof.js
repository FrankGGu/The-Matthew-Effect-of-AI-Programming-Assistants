function decrypt(nums, key) {
    const n = nums.length;
    const result = new Array(n);
    for (let i = 0; i < n; i++) {
        result[i] = nums[(i - key + n) % n];
    }
    return result;
}