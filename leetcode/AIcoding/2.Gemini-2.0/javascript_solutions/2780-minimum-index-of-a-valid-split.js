var minimumIndex = function(nums) {
    const n = nums.length;
    const totalCount = {};
    for (const num of nums) {
        totalCount[num] = (totalCount[num] || 0) + 1;
    }

    let dominant = null;
    let dominantCount = 0;
    for (const num in totalCount) {
        if (totalCount[num] > dominantCount) {
            dominantCount = totalCount[num];
            dominant = parseInt(num);
        }
    }

    let leftCount = 0;
    for (let i = 0; i < n - 1; i++) {
        if (nums[i] === dominant) {
            leftCount++;
        }

        const leftSize = i + 1;
        const rightSize = n - leftSize;
        const rightCount = dominantCount - leftCount;

        if (leftCount * 2 > leftSize && rightCount * 2 > rightSize) {
            return i;
        }
    }

    return -1;
};