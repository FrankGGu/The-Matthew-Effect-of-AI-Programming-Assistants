var maxBalancedSubsequenceSum = function(nums) {
    const n = nums.length;
    const arr = [];
    for (let i = 0; i < n; i++) {
        arr.push(nums[i] - (i + 1));
    }

    const sortedArr = [...new Set(arr)].sort((a, b) => a - b);

    const bit = new Array(sortedArr.length + 1).fill(-Infinity);

    function update(i, val) {
        while (i <= sortedArr.length) {
            bit[i] = Math.max(bit[i], val);
            i += (i & -i);
        }
    }

    function query(i) {
        let res = -Infinity;
        while (i > 0) {
            res = Math.max(res, bit[i]);
            i -= (i & -i);
        }
        return res;
    }

    let ans = -Infinity;

    for (let i = 0; i < n; i++) {
        const idx = sortedArr.indexOf(nums[i] - (i + 1)) + 1;
        let prev = query(idx);
        let curr = nums[i];
        if (prev > -Infinity) {
            curr = Math.max(curr, prev + nums[i]);
        }
        ans = Math.max(ans, curr);
        update(idx, curr);
    }

    return ans;
};