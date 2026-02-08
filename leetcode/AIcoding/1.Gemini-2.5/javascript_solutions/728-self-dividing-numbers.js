var selfDividingNumbers = function(left, right) {
    const result = [];

    for (let i = left; i <= right; i++) {
        let isSelfDividing = true;
        let temp = i;
        while (temp > 0) {
            const digit = temp % 10;
            if (digit === 0 || i % digit !== 0) {
                isSelfDividing = false;
                break;
            }
            temp = Math.floor(temp / 10);
        }
        if (isSelfDividing) {
            result.push(i);
        }
    }

    return result;
};