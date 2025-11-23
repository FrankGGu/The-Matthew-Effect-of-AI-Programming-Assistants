var deleteAndEarn = function(nums) {
    if (nums.length === 0) return 0;

    const maxNum = Math.max(...nums);
    const points = new Array(maxNum + 1).fill(0);

    for (const num of nums) {
        points[num] += num;
    }

    let prev = 0;
    let curr = points[1];

    for (let i = 2; i < points.length; i++) {
        const temp = Math.max(curr, prev + points[i]);
        prev = curr;
        curr = temp;
    }

    return curr;
};