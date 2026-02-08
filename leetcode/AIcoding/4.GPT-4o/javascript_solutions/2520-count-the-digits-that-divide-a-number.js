var countDigits = function(num) {
    let count = 0;
    const digits = num.toString().split('');
    for (let digit of digits) {
        if (num % parseInt(digit) === 0) {
            count++;
        }
    }
    return count;
};