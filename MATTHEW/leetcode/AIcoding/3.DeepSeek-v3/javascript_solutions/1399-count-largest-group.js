var countLargestGroup = function(n) {
    const sumDigits = (num) => {
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        return sum;
    };

    const groups = {};
    let maxSize = 0;

    for (let i = 1; i <= n; i++) {
        const sum = sumDigits(i);
        groups[sum] = (groups[sum] || 0) + 1;
        maxSize = Math.max(maxSize, groups[sum]);
    }

    let count = 0;
    for (const key in groups) {
        if (groups[key] === maxSize) {
            count++;
        }
    }

    return count;
};