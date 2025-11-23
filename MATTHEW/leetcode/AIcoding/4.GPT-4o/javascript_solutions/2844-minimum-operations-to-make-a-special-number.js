var minimumOperations = function(num) {
    const digits = num.toString().split('');
    let count = 0;

    for (let i = 0; i < digits.length; i++) {
        if (digits[i] !== '0') {
            count++;
        }
    }

    return count;
};