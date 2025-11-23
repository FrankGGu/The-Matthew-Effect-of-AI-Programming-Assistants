var minimizeXor = function(num1, num2) {
    const countBits = (n) => {
        let count = 0;
        while (n > 0) {
            count += n & 1;
            n >>= 1;
        }
        return count;
    };

    const targetCount = countBits(num2);
    let currentCount = countBits(num1);
    let result = num1;

    if (currentCount === targetCount) {
        return result;
    } else if (currentCount < targetCount) {
        let diff = targetCount - currentCount;
        for (let i = 0; i < 32 && diff > 0; i++) {
            if ((result & (1 << i)) === 0) {
                result |= (1 << i);
                diff--;
            }
        }
    } else {
        let diff = currentCount - targetCount;
        for (let i = 0; i < 32 && diff > 0; i++) {
            if ((result & (1 << i)) !== 0) {
                result ^= (1 << i);
                diff--;
            }
        }
    }

    return result;
};