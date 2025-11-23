function findDifferentBinaryString(nums) {
    const n = nums.length;
    const seen = new Set(nums);
    for (let i = 0; i < (1 << n); i++) {
        const binary = i.toString(2).padStart(n, '0');
        if (!seen.has(binary)) {
            return binary;
        }
    }
    return '';
}