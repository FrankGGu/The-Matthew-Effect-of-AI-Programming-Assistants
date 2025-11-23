var smallestValue = function(n) {
    function sumOfPrimeFactors(num) {
        let sum = 0;
        let tempNum = num;

        for (let i = 2; i * i <= tempNum; i++) {
            while (tempNum % i === 0) {
                sum += i;
                tempNum /= i;
            }
        }

        if (tempNum > 1) {
            sum += tempNum;
        }
        return sum;
    }

    let currentN = n;
    let nextN;

    while (true) {
        nextN = sumOfPrimeFactors(currentN);
        if (nextN === currentN) {
            break;
        }
        currentN = nextN;
    }

    return currentN;
};