var maxNumberOfAlloys = function(n, k, budget, composition, stock, cost) {
    let low = 0;
    // A sufficiently large upper bound for the number of alloys.
    // Based on budget and stock, roughly 2 * 10^9 is a safe maximum.
    let high = 2 * 10**9;
    let ans = 0;

    // Convert relevant input values to BigInt to prevent overflow during calculations.
    // Maximum required metal for one alloy could be 10^9.
    // If numAlloys is 2*10^9, then requiredMetal = 10^9 * 2*10^9 = 2*10^18.
    // This exceeds JavaScript's safe integer limit (2^53 - 1, approx 9*10^15).
    // Cost calculations can go even higher.
    const bigBudget = BigInt(budget);
    const bigStock = stock.map(s => BigInt(s));
    const bigCost = cost.map(c => BigInt(c));
    const bigComposition = composition.map(comp => comp.map(c => BigInt(c)));

    // Helper function to check if it's possible to produce 'numAlloys' units
    // using any of the factories within the given budget and stock.
    const check = (numAlloys) => {
        const bigNumAlloys = BigInt(numAlloys);

        for (let i = 0; i < k; i++) { // Iterate through each factory
            let currentFactoryCost = 0n; // Use BigInt for cost calculation

            for (let j = 0; j < n; j++) { // Iterate through each metal type
                const requiredMetal = bigComposition[i][j] * bigNumAlloys;

                // Calculate how much metal needs to be bought
                const neededToBuy = requiredMetal > bigStock[j] ? requiredMetal - bigStock[j] : 0n;

                // Add the cost of buying the needed metal
                currentFactoryCost += neededToBuy * bigCost[j];

                // Optimization: If the cost for this factory already exceeds the budget,
                // no need to check further metals for this factory.
                if (currentFactoryCost > bigBudget) {
                    break;
                }
            }

            // If this factory can produce 'numAlloys' within budget, return true
            if (currentFactoryCost <= bigBudget) {
                return true;
            }
        }
        // No factory can produce 'numAlloys'
        return false;
    };

    // Binary search for the maximum number of alloys
    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;       // It's possible to make 'mid' alloys, so store it as a potential answer
            low = mid + 1;   // Try to make more alloys
        } else {
            high = mid - 1;  // Cannot make 'mid' alloys, so try fewer
        }
    }

    return ans;
};