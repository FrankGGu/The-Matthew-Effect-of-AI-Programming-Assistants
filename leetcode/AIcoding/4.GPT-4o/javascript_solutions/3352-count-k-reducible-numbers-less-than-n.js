var countKReducibleNumbers = function(n, k) {
    let count = 0;

    for (let i = 1; i < n; i++) {
        let num = i;
        let sumDigits = 0;

        while (num > 0) {
            sumDigits += num % 10;
            num = Math.floor(num / 10);
        }

        if (sumDigits % k === 0) {
            count++;
        }
    }

    return count;
};