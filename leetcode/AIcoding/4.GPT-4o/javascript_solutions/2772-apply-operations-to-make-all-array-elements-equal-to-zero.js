function applyOperations(nums) {
    let n = nums.length;
    let result = new Array(n).fill(0);
    let index = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] !== 0) {
            if (i < n - 1 && nums[i] === nums[i + 1]) {
                result[index++] = nums[i] * 2;
                i++;
            } else {
                result[index++] = nums[i];
            }
        }
    }

    return result.slice(0, index).concat(new Array(n - index).fill(0));
}