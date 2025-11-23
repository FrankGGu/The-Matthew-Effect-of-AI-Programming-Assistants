var findErrorNums = function(nums) {
    const n = nums.length;
    const count = new Array(n + 1).fill(0);
    let duplicate = -1;
    let missing = -1;

    for (let num of nums) {
        count[num]++;
        if (count[num] > 1) {
            duplicate = num;
        }
    }

    for (let i = 1; i <= n; i++) {
        if (count[i] === 0) {
            missing = i;
            break;
        }
    }

    return [duplicate, missing];
};