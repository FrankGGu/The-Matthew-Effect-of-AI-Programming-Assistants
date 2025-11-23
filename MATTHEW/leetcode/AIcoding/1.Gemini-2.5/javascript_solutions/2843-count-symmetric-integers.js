var countSymmetricIntegers = function(low, high) {
    let count = 0;

    for (let i = low; i <= high; i++) {
        const s = String(i);
        const n = s.length;

        if (n % 2 === 0) {
            let sumFirstHalf = 0;
            let sumSecondHalf = 0;

            for (let j = 0; j < n / 2; j++) {
                sumFirstHalf += parseInt(s[j]);
            }

            for (let j = n / 2; j < n; j++) {
                sumSecondHalf += parseInt(s[j]);
            }

            if (sumFirstHalf === sumSecondHalf) {
                count++;
            }
        }
    }

    return count;
};