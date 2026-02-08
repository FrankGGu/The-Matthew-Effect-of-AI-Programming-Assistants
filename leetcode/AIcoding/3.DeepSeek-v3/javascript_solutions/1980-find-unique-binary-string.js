var findDifferentBinaryString = function(nums) {
    const n = nums.length;
    const seen = new Set(nums);

    for (let i = 0; i < (1 << n); i++) {
        let binary = i.toString(2).padStart(n, '0');
        if (!seen.has(binary)) {
            return binary;
        }
    }

    return "";
};