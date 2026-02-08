var getXSum = function(nums, k) {
    let n = nums.length;
    let prefixXOR = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixXOR[i + 1] = prefixXOR[i] ^ nums[i];
    }
    let total = 0;
    for (let i = 0; i <= n - k; i++) {
        total += prefixXOR[i + k] ^ prefixXOR[i];
    }
    return total;
};