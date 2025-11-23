var maximizeAmount = function(initialAmount, conversionRates1, conversionRates2) {
    const n = conversionRates1.length;

    // Initialize maxRateDay1 matrix
    // maxRateDay1[i][j] will store the maximum conversion rate from currency i to currency j on Day 1.
    const maxRateDay1 = Array(n).fill(0).map(() => Array(n).fill(0.0));
    for (let i = 0; i < n; i++) {
        maxRateDay1[i][i] = 1.0; // Can choose to hold currency (rate 1.0)
        for (let j = 0; j < n; j++) {
            if (conversionRates1[i][j] !== -1) {
                maxRateDay1[i][j] = conversionRates1[i][j];
            }
        }
    }

    // Floyd-Warshall algorithm for Day 1
    // Finds the maximum product path between any two currencies within Day 1.
    for (let k = 0; k < n; k++) { // Intermediate currency
        for (let i = 0; i < n; i++) { // Starting currency
            for (let j = 0; j < n; j++) { // Ending currency
                // If there's a path from i to k and k to j, consider converting i -> k -> j
                // Only consider paths where rates are positive, as 0 rate means no gain and -1 means no direct path.
                if (maxRateDay1[i][k] > 0 && maxRateDay1[k][j] > 0) {
                    maxRateDay1[i][j] = Math.max(maxRateDay1[i][j], maxRateDay1[i][k] * maxRateDay1[k][j]);
                }
            }
        }
    }

    // Initialize maxRateDay2 matrix
    // maxRateDay2[i][j] will store the maximum conversion rate from currency i to currency j on Day 2.
    const maxRateDay2 = Array(n).fill(0).map(() => Array(n).fill(0.0));
    for (let i = 0; i < n; i++) {
        maxRateDay2[i][i] = 1.0; // Can choose to hold currency (rate 1.0)
        for (let j = 0; j < n; j++) {
            if (conversionRates2[i][j] !== -1) {
                maxRateDay2[i][j] = conversionRates2[i][j];
            }
        }
    }

    // Floyd-Warshall algorithm for Day 2
    // Finds the maximum product path between any two currencies within Day 2.
    for (let k = 0; k < n; k++) { // Intermediate currency
        for (let i = 0; i < n; i++) { // Starting currency
            for (let j = 0; j < n; j++) { // Ending currency
                // If there's a path from i to k and k to j, consider converting i -> k -> j
                if (maxRateDay2[i][k] > 0 && maxRateDay2[k][j] > 0) {
                    maxRateDay2[i][j] = Math.max(maxRateDay2[i][j], maxRateDay2[i][k] * maxRateDay2[k][j]);
                }
            }
        }
    }

    // Combine results from Day 1 and Day 2
    // We start with currency 0.
    // On Day 1, we convert currency 0 to some intermediate currency 'k'.
    // On Day 2, we convert currency 'k' back to currency 0.
    // We want to maximize the final amount of currency 0.

    // Initialize maxOverallRate with 1.0, representing the case of doing nothing for two days
    // (i.e., currency 0 -> currency 0 on Day 1, then currency 0 -> currency 0 on Day 2).
    let maxOverallRate = 1.0; 

    for (let k = 0; k < n; k++) { // Intermediate currency after Day 1
        // If there's a path from 0 to k on Day 1 and a path from k to 0 on Day 2
        if (maxRateDay1[0][k] > 0 && maxRateDay2[k][0] > 0) {
            maxOverallRate = Math.max(maxOverallRate, maxRateDay1[0][k] * maxRateDay2[k][0]);
        }
    }

    return initialAmount * maxOverallRate;
};