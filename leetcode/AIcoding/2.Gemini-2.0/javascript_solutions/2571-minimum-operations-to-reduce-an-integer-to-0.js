var minOperations = function(n) {
    let operations = 0;
    while (n > 0) {
        if (n % 2 === 0) {
            n /= 2;
        } else {
            if ((n + 1) % 4 === 0 && n !== 3) {
                n++;
            } else {
                n--;
            }
        }
        operations++;
    }
    return operations;
};