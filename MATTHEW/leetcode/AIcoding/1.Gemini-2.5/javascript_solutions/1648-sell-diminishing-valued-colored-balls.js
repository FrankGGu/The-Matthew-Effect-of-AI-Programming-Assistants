var maxProfit = function(inventory, orders) {
    const MOD = 10**9 + 7;

    let maxVal = 0;
    for (const val of inventory) {
        maxVal = Math.max(maxVal, val);
    }

    // Function to calculate the total number of balls that can be sold if we sell all balls
    // with a value strictly greater than 'price - 1' (i.e., all balls with value >= price).
    // This is equivalent to sum(max(0, inventory[i] - price + 1)) for all i.
    const countBallsAboveOrEqual = (price) => {
        let count = 0;
        for (const val of inventory) {
            if (val >= price) {
                count += (val - price + 1);
            }
        }
        return count;
    };

    // Binary search to find P_prime: the minimum price of a ball that we actually sell.
    // We want the largest P_prime such that countBallsAboveOrEqual(P_prime) >= orders.
    // This ensures we can fulfill 'orders' by selling balls at prices >= P_prime.
    let low = 1;
    let high = maxVal;
    let P_prime = 1; // P_prime will store the largest price 'mid' that satisfies the condition.

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (countBallsAboveOrEqual(mid) >= orders) {
            P_prime = mid;
            low = mid + 1; // Try to find an even larger P_prime (sell fewer balls at higher prices)
        } else {
            high = mid - 1; // 'mid' is too high (selling too few balls), need to decrease P_prime
        }
    }

    let totalProfit = 0;
    let ballsSoldStrictlyGreaterThanP_prime = 0;

    // Calculate profit from balls sold at prices strictly greater than P_prime
    for (const val of inventory) {
        if (val > P_prime) {
            const numToSell = val - P_prime;
            ballsSoldStrictlyGreaterThanP_prime += numToSell;

            // Sum of arithmetic series from (P_prime + 1) to val
            // Sum = (start_val + end_val) * count_vals / 2
            const startVal = P_prime + 1;
            const endVal = val;
            const countVals = numToSell;

            // Calculate (A * B / 2) % MOD safely
            // One of (startVal + endVal) or countVals is guaranteed to be even.
            let term1 = startVal + endVal;
            let term2 = countVals;

            let currentSum;
            if (term1 % 2 === 0) {
                currentSum = (term1 / 2) % MOD;
                currentSum = (currentSum * (term2 % MOD)) % MOD;
            } else { // term2 must be even
                currentSum = (term2 / 2) % MOD;
                currentSum = (currentSum * (term1 % MOD)) % MOD;
            }

            totalProfit = (totalProfit + currentSum) % MOD;
        }
    }

    // Calculate profit from remaining orders, all sold at price P_prime
    const remainingOrders = orders - ballsSoldStrictlyGreaterThanP_prime;

    totalProfit = (totalProfit + (remainingOrders % MOD) * (P_prime % MOD)) % MOD;

    return totalProfit;
};