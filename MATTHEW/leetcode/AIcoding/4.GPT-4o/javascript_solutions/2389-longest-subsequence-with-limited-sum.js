var maxLength = function(nums, limit) {
    nums.sort((a, b) => a - b);
    let sum = 0, count = 0;

    for (let num of nums) {
        if (sum + num <= limit) {
            sum += num;
            count++;
        } else {
            break;
        }
    }

    return count;
};