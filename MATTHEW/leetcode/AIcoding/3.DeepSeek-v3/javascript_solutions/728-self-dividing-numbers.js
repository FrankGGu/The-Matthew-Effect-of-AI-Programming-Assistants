var selfDividingNumbers = function(left, right) {
    const result = [];
    for (let i = left; i <= right; i++) {
        if (isSelfDividing(i)) {
            result.push(i);
        }
    }
    return result;
};

function isSelfDividing(num) {
    let original = num;
    while (num > 0) {
        const digit = num % 10;
        if (digit === 0 || original % digit !== 0) {
            return false;
        }
        num = Math.floor(num / 10);
    }
    return true;
}