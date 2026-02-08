var returnToBoundaryCount = function(nums) {
    let position = 0;
    let count = 0;
    for (let num of nums) {
        position += num;
        if (position === 0) {
            count++;
        }
    }
    return count;
};