var minimumNumbers = function(num, k) {
    if (num === 0) {
        return 0;
    }

    for (let m = 1; m <= 10; m++) {
        let currentSumOfKUnits = m * k;

        if (currentSumOfKUnits > num) {
            break;
        }

        let remainder = num - currentSumOfKUnits;

        if (remainder % 10 === 0) {
            if (k > 0) {
                return m;
            } else { // k === 0
                if (num >= m * 10) {
                    return m;
                }
            }
        }
    }

    return -1;
};