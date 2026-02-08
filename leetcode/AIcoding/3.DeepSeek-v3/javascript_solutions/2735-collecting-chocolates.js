var minCost = function(nums, x) {
    const n = nums.length;
    let minCost = Infinity;
    const rotated = [...nums];

    for (let rotate = 0; rotate < n; rotate++) {
        let currentCost = rotate * x;
        for (let i = 0; i < n; i++) {
            const originalIndex = (i - rotate + n) % n;
            rotated[i] = Math.min(rotated[i], nums[originalIndex]);
        }
        currentCost += rotated.reduce((a, b) => a + b, 0);
        if (currentCost < minCost) {
            minCost = currentCost;
        }
    }

    return minCost;
};