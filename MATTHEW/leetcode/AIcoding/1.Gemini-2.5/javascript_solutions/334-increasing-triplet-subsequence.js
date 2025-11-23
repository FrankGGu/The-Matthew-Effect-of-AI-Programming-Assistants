var increasingTriplet = function(nums) {
    let min1 = Infinity;
    let min2 = Infinity;

    for (let num of nums) {
        if (num <= min1) {
            min1 = num;
        } else if (num <= min2) {
            min2 = num;
        } else {
            return true;
        }
    }

    return false;
};