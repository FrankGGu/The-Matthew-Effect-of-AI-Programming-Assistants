var thirdMax = function(nums) {
    let first = -Infinity;
    let second = -Infinity;
    let third = -Infinity;

    for (let num of nums) {
        if (num > first) {
            third = second;
            second = first;
            first = num;
        } else if (num > second && num < first) {
            third = second;
            second = num;
        } else if (num > third && num < second) {
            third = num;
        }
    }

    if (third === -Infinity) {
        return first;
    } else {
        return third;
    }
};