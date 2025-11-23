var deleteAndEarn = function(nums) {
    const maxNum = Math.max(...nums);
    const points = new Array(maxNum + 1).fill(0);

    for (const num of nums) {
        points[num] += num;
    }

    let prev = 0, curr = 0;
    for (let i = 0; i <= maxNum; i++) {
        const temp = curr;
        curr = Math.max(curr, prev + points[i]);
        prev = temp;
    }

    return curr;
};