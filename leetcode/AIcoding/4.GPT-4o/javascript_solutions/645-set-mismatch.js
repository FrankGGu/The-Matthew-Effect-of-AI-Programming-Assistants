var findErrorNums = function(nums) {
    const n = nums.length;
    const count = new Array(n + 1).fill(0);
    let duplicate, missing;

    for (let num of nums) {
        count[num]++;
    }

    for (let i = 1; i <= n; i++) {
        if (count[i] === 2) {
            duplicate = i;
        } else if (count[i] === 0) {
            missing = i;
        }
    }

    return [duplicate, missing];
};