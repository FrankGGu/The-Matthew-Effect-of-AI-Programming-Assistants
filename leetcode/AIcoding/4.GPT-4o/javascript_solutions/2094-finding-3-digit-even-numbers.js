var findEvenNumbers = function(digits) {
    const result = new Set();

    for (let num of digits) {
        if (num.length === 3) {
            let lastDigit = parseInt(num[num.length - 1]);
            if (lastDigit % 2 === 0) {
                result.add(num);
            }
        }
    }

    return Array.from(result).sort();
};