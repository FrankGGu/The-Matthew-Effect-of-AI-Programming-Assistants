var findEvenNumbers = function(digits) {
    const result = new Set();
    for (let i = 100; i < 1000; i++) {
        const numStr = i.toString();
        if (numStr[2] % 2 === 0 && new Set(numStr).size === 3) {
            result.add(numStr);
        }
    }
    return Array.from(result).map(Number);
};