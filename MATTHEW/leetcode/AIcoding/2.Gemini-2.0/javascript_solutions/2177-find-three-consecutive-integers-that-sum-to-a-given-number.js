var sumOfThree = function(num) {
    if (num % 3 !== 0) {
        return [];
    }
    let mid = num / 3;
    return [mid - 1, mid, mid + 1];
};