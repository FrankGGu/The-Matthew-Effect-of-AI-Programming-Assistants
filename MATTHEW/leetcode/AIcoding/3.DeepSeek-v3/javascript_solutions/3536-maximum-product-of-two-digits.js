var maxProduct = function(nums) {
    let max1 = -Infinity;
    let max2 = -Infinity;
    let min1 = Infinity;
    let min2 = Infinity;

    for (const num of nums) {
        if (num > max1) {
            max2 = max1;
            max1 = num;
        } else if (num > max2) {
            max2 = num;
        }

        if (num < min1) {
            min2 = min1;
            min1 = num;
        } else if (num < min2) {
            min2 = num;
        }
    }

    return Math.max((max1 - 1) * (max2 - 1), (min1 - 1) * (min2 - 1));
};