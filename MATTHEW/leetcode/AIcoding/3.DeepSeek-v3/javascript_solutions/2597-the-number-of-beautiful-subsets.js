var beautifulSubsets = function(nums, k) {
    let count = 0;
    const n = nums.length;

    function backtrack(start, current) {
        if (current.length > 0) {
            count++;
        }
        for (let i = start; i < n; i++) {
            let valid = true;
            for (const num of current) {
                if (Math.abs(num - nums[i]) === k) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                current.push(nums[i]);
                backtrack(i + 1, current);
                current.pop();
            }
        }
    }

    backtrack(0, []);
    return count;
};