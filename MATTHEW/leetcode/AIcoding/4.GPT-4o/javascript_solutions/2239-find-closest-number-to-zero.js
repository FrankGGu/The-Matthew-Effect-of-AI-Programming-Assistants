var findClosestNumber = function(nums) {
    let closest = Infinity;
    for (let num of nums) {
        if (Math.abs(num) < Math.abs(closest) || (Math.abs(num) === Math.abs(closest) && num > closest)) {
            closest = num;
        }
    }
    return closest;
};