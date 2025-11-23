var reorderedPowerOf2 = function(N) {
    const countDigits = (num) => {
        const count = new Array(10).fill(0);
        while (num > 0) {
            count[num % 10]++;
            num = Math.floor(num / 10);
        }
        return count;
    };

    const originalCount = countDigits(N);
    for (let i = 0; i < 31; i++) {
        const powerOf2 = 1 << i;
        if (countDigits(powerOf2).toString() === originalCount.toString()) {
            return true;
        }
    }
    return false;
};