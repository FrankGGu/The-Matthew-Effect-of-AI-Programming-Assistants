var countElements = function(nums) {
    const min = Math.min(...nums);
    const max = Math.max(...nums);
    let count = 0;
    for (let num of nums) {
        if (num > min && num < max) {
            count++;
        }
    }
    return count;
};