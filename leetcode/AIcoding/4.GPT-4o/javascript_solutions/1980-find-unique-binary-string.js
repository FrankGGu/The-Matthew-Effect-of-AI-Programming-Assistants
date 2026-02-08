var findUniqueBinaryString = function(nums) {
    let n = nums.length;
    let seen = new Set(nums);

    function backtrack(prefix) {
        if (prefix.length === n) {
            return prefix;
        }
        for (let i = 0; i < 2; i++) {
            let candidate = prefix + i;
            if (!seen.has(candidate)) {
                let result = backtrack(candidate);
                if (result) return result;
            }
        }
        return null;
    }

    return backtrack('');
};