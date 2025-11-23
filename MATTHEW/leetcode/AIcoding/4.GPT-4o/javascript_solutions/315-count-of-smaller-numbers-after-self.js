var countSmaller = function(nums) {
    const result = new Array(nums.length).fill(0);
    const sorted = [];

    const insert = (num) => {
        let left = 0, right = sorted.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (sorted[mid] < num) left = mid + 1;
            else right = mid;
        }
        sorted.splice(left, 0, num);
        return left;
    };

    for (let i = nums.length - 1; i >= 0; i--) {
        result[i] = insert(nums[i]);
    }

    return result;
};