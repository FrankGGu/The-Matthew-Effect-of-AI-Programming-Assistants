var countDigits = function(num) {
    let count = 0;
    let originalNum = num;
    while (num > 0) {
        const digit = num % 10;
        if (originalNum % digit === 0) {
            count++;
        }
        num = Math.floor(num / 10);
    }
    return count;
};