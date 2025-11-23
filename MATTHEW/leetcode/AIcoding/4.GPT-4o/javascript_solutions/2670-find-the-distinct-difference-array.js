function distinctDifferenceArray(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    const leftCount = new Map();
    const rightCount = new Map();

    for (const num of nums) {
        rightCount.set(num, (rightCount.get(num) || 0) + 1);
    }

    for (let i = 0; i < n; i++) {
        const num = nums[i];

        leftCount.set(num, (leftCount.get(num) || 0) + 1);
        rightCount.set(num, rightCount.get(num) - 1);
        if (rightCount.get(num) === 0) {
            rightCount.delete(num);
        }

        result[i] = leftCount.size - rightCount.size;
    }

    return result;
}