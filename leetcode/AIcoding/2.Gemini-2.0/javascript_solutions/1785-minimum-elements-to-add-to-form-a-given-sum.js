var minElements = function(nums, limit, goal) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }

    let diff = Math.abs(goal - sum);

    return Math.ceil(diff / limit);
};