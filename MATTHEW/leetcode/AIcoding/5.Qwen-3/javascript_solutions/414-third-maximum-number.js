function thirdMaximumNumber(nums) {
    let first = -Infinity, second = -Infinity, third = -Infinity;

    for (let num of nums) {
        if (num === first || num === second || num === third) continue;
        if (num > first) {
            third = second;
            second = first;
            first = num;
        } else if (num > second) {
            third = second;
            second = num;
        } else if (num > third) {
            third = num;
        }
    }

    return third === -Infinity ? first : third;
}