var distinctPrimeFactors = function(nums) {
    const distinctPrimes = new Set();

    for (let num of nums) {
        let currentNum = num;

        // Check for factor 2
        while (currentNum % 2 === 0) {
            distinctPrimes.add(2);
            currentNum /= 2;
        }

        // Check for odd factors from 3 up to sqrt(currentNum)
        for (let i = 3; i * i <= currentNum; i += 2) {
            while (currentNum % i === 0) {
                distinctPrimes.add(i);
                currentNum /= i;
            }
        }

        // If currentNum is still greater than 1, it must be a prime factor itself
        if (currentNum > 1) {
            distinctPrimes.add(currentNum);
        }
    }

    return distinctPrimes.size;
};