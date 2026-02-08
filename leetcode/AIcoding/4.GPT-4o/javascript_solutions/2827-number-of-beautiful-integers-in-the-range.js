var beautifulNumbers = function(low, high) {
    const isBeautiful = (num) => {
        const strNum = num.toString();
        const digitCount = new Array(10).fill(0);
        for (let char of strNum) {
            digitCount[char - '0']++;
        }
        return digitCount.filter(count => count > 0).length === 2;
    };

    let count = 0;
    for (let i = low; i <= high; i++) {
        if (isBeautiful(i)) {
            count++;
        }
    }
    return count;
};