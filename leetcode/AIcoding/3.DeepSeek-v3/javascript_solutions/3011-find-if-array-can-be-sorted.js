var canSortArray = function(nums) {
    const countOnes = (num) => {
        let count = 0;
        while (num > 0) {
            count += num & 1;
            num = num >> 1;
        }
        return count;
    };

    const n = nums.length;
    const ones = nums.map(num => countOnes(num));

    for (let i = 0; i < n - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            if (ones[i] !== ones[i + 1]) {
                return false;
            }
        }
    }

    return true;
};