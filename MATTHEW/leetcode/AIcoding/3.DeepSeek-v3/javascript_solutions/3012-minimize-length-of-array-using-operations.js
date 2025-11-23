var minimumArrayLength = function(nums) {
    let min = Math.min(...nums);
    let count = 0;
    for (let num of nums) {
        if (num === min) {
            count++;
        }
    }
    for (let num of nums) {
        if (num % min !== 0) {
            return 1;
        }
    }
    return Math.ceil(count / 2);
};