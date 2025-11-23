function maximumCount(nums) {
    let positive = 0;
    let negative = 0;
    for (let num of nums) {
        if (num > 0) positive++;
        else if (num < 0) negative++;
    }
    return Math.max(positive, negative);
}