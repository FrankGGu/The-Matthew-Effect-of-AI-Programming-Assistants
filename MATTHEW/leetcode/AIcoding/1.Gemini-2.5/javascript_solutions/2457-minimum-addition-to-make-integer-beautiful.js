var makeIntegerBeautiful = function(n, target) {
    let currentN = BigInt(n);
    let x = 0n;
    let powerOfTen = 1n;

    const sumDigits = (num) => {
        let sum = 0;
        let tempNum = num;
        while (tempNum > 0n) {
            sum += Number(tempNum % 10n);
            tempNum = tempNum / 10n;
        }
        return sum;
    };

    if (sumDigits(currentN) <= target) {
        return 0;
    }

    while (sumDigits(currentN) > target) {
        let digit = (currentN / powerOfTen) % 10n;

        if (digit !== 0n) {
            let neededToAdd = (10n - digit) * powerOfTen;
            x += neededToAdd;
            currentN += neededToAdd;
        }
        powerOfTen *= 10n;
    }

    return Number(x);
};