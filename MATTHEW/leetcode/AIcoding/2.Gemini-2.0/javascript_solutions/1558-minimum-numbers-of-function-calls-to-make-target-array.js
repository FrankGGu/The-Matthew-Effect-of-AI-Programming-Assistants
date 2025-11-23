var minOperations = function(nums) {
    let ans = 0;
    let maxBit = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > 0) {
            ans += countSetBits(nums[i]);
            maxBit = Math.max(maxBit, Math.floor(Math.log2(nums[i])));
        }
    }

    ans += maxBit;

    return ans;

    function countSetBits(n) {
        let count = 0;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }
};