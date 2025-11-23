var minimizeXor = function(num1, num2) {
    let count = 0;
    for (let i = 0; i < 32; i++) {
        if (num2 & (1 << i)) count++;
    }

    let result = 0;
    for (let i = 31; i >= 0 && count > 0; i--) {
        if (num1 & (1 << i)) {
            result |= (1 << i);
        } else if (count > 0) {
            result |= (1 << i);
            count--;
        }
    }

    return result;
};