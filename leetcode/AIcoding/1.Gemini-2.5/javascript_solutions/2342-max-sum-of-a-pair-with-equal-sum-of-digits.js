var maximumSum = function(nums) {
    // Helper function to calculate the sum of digits for a number
    const getDigitSum = (num) => {
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        return sum;
    };

    // Map to store numbers grouped by their sum of digits.
    // Each value will be an array containing the two largest numbers found so far for that digit sum.
    // The array will be sorted in descending order: [largest, second_largest].
    const digitSumMap = new Map();

    // Iterate through the input numbers
    for (const num of nums) {
        const currentDigitSum = getDigitSum(num);

        // Get the current list of top two numbers for this digit sum
        let currentTopTwo = digitSumMap.get(currentDigitSum) || [];

        if (currentTopTwo.length === 0) {
            // First number for this digit sum
            currentTopTwo.push(num);
        } else if (currentTopTwo.length === 1) {
            // Second number for this digit sum
            if (num > currentTopTwo[0]) {
                currentTopTwo.unshift(num); // num is larger, becomes first
            } else {
                currentTopTwo.push(num); // num is smaller, becomes second
            }
        } else { // currentTopTwo.length === 2, already has [n1, n2] where n1 >= n2
            if (num > currentTopTwo[0]) {
                // num is larger than current largest, shift existing largest down
                currentTopTwo[1] = currentTopTwo[0];
                currentTopTwo[0] = num;
            } else if (num > currentTopTwo[1]) {
                // num is larger than current second largest, replace it
                currentTopTwo[1] = num;
            }
            // If num is smaller than both, it's not one of the top two, so we don't store it.
        }

        // Update the map with the (potentially updated) top two numbers
        digitSumMap.set(currentDigitSum, currentTopTwo);
    }

    let maxSum = -1; // Initialize max sum to -1 as per problem statement

    // Iterate through the map values (arrays of top two numbers)
    for (const topTwoNums of digitSumMap.values()) {
        // We only care about digit sums that have at least two numbers
        if (topTwoNums.length === 2) {
            const currentSum = topTwoNums[0] + topTwoNums[1];
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};