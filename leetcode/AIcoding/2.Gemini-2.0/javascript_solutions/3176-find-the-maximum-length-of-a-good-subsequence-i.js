var findMaximumLength = function(nums) {
    let sum = 0;
    let count = 0;
    let maxVal = 0;

    nums.sort((a, b) => a - b);

    for (let num of nums) {
        if (num <= sum) {
            sum += num;
            count++;
        } else {
            maxVal = num;
        }
    }

    if (maxVal > sum) {
        return count;
    } else {
        return count + 1;
    }
};