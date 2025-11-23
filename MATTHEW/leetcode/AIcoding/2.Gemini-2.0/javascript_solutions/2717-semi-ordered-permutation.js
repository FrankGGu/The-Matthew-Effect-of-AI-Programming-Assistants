var semiOrderedPermutation = function(nums) {
    let n = nums.length;
    let pos1 = -1;
    let posN = -1;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            pos1 = i;
        } else if (nums[i] === n) {
            posN = i;
        }
    }

    let ans = pos1 + (n - 1 - posN);
    if (pos1 > posN) {
        ans--;
    }

    return ans;
};