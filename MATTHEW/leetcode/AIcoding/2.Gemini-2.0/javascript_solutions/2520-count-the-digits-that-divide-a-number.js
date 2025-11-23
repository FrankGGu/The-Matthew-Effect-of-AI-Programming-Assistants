var countDigits = function(num) {
    let count = 0;
    const numStr = num.toString();
    for (let i = 0; i < numStr.length; i++) {
        const digit = parseInt(numStr[i]);
        if (num % digit === 0) {
            count++;
        }
    }
    return count;
};