var sumFourDivisors = function(nums) {
    let totalSum = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        let divisorsCount = 0;
        let currentSumOfDivisors = 0;
        let sqrtNum = Math.sqrt(num);

        for (let j = 1; j <= sqrtNum; j++) {
            if (num % j === 0) {
                // j is a divisor
                divisorsCount++;
                currentSumOfDivisors += j;

                if (j * j !== num) {
                    // num / j is another distinct divisor
                    divisorsCount++;
                    currentSumOfDivisors += (num / j);
                }
            }
            // Optimization: If we already have more than 4 divisors, we can stop early.
            // This is because we only care about exactly 4 divisors.
            if (divisorsCount > 4) {
                break;
            }
        }

        if (divisorsCount === 4) {
            totalSum += currentSumOfDivisors;
        }
    }

    return totalSum;
};