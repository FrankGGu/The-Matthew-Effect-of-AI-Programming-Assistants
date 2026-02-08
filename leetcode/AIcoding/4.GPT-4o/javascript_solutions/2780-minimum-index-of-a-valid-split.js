function minimumIndex(nums) {
    const n = nums.length;
    const count = new Map();
    let maxCount = 0, candidate = -1;

    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
        if (count.get(num) > maxCount) {
            maxCount = count.get(num);
            candidate = num;
        }
    }

    let leftCount = 0, rightCount = maxCount;
    for (let i = 0; i < n; i++) {
        if (nums[i] === candidate) {
            leftCount++;
            rightCount--;
        }
        if (leftCount > (i + 1) / 2 && rightCount > (n - i - 1) / 2) {
            return i;
        }
    }

    return -1;
}