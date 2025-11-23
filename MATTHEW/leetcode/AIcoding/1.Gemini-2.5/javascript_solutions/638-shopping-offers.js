var shoppingOffers = function(prices, offers, needs) {
    const n = prices.length;

    const filteredOffers = [];
    for (const offer of offers) {
        let individualPriceForOffer = 0;
        for (let i = 0; i < n; i++) {
            individualPriceForOffer += offer[i] * prices[i];
        }
        // Only consider offers that are strictly cheaper than buying the items individually.
        // If an offer costs more or equal, it's never optimal to take it directly.
        // This pruning helps reduce the search space.
        if (offer[n] < individualPriceForOffer) {
            filteredOffers.push(offer);
        }
    }

    const memo = new Map();

    // Helper function to calculate the cost of buying items individually
    const calculateIndividualCost = (currentNeeds) => {
        let cost = 0;
        for (let i = 0; i < n; i++) {
            cost += currentNeeds[i] * prices[i];
        }
        return cost;
    };

    // DFS function to find the minimum cost
    const dfs = (currentNeeds) => {
        const key = currentNeeds.join(',');
        if (memo.has(key)) {
            return memo.get(key);
        }

        // Option 1: Buy all remaining items individually. This is a baseline cost.
        let minCost = calculateIndividualCost(currentNeeds);

        // Option 2: Try applying each filtered offer
        for (const offer of filteredOffers) {
            const nextNeeds = Array(n).fill(0);
            let canApply = true;

            // Check if the current offer can be applied given the current needs
            for (let i = 0; i < n; i++) {
                if (currentNeeds[i] < offer[i]) {
                    canApply = false;
                    break;
                }
                nextNeeds[i] = currentNeeds[i] - offer[i];
            }

            if (canApply) {
                // Recursively calculate cost for remaining needs after applying the offer
                // and update minCost if this path is cheaper
                minCost = Math.min(minCost, offer[n] + dfs(nextNeeds));
            }
        }

        memo.set(key, minCost);
        return minCost;
    };

    return dfs(needs);
};