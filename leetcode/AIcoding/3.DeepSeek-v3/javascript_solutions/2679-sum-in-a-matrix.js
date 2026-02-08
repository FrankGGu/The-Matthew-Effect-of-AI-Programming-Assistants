var matrixSum = function(nums) {
    for (let row of nums) {
        row.sort((a, b) => b - a);
    }
    let score = 0;
    for (let col = 0; col < nums[0].length; col++) {
        let max = 0;
        for (let row = 0; row < nums.length; row++) {
            max = Math.max(max, nums[row][col]);
        }
        score += max;
    }
    return score;
};