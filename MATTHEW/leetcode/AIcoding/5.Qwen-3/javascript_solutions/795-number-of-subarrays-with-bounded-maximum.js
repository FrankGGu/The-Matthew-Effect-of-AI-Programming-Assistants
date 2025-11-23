function numSubarrayBoundedSolutions(upper, lower, nums) {
    function count(end) {
        let res = 0, prev = 0;
        for (let i = 0; i <= end; i++) {
            if (nums[i] < lower) {
                res += prev;
            } else if (nums[i] > upper) {
                prev = 0;
            } else {
                prev++;
                res += prev;
            }
        }
        return res;
    }
    return count(nums.length - 1);
}