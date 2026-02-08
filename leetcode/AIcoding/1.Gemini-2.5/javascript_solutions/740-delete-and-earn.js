var deleteAndEarn = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    let maxVal = 0;
    for (const num of nums) {
        if (num > maxVal) {
            maxVal = num;
        }
    }

    const points = new Array(maxVal + 1).fill(0);
    for (const num of nums) {
        points[num] += num;
    }

    let prev = 0;
    let curr = 0;

    for (let i = 0; i <= maxVal; i++) {
        let temp = curr;
        curr = Math.max(curr, prev + points[i]);
        prev = temp;
    }

    return curr;
};