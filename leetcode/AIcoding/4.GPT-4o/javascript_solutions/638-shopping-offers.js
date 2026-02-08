var shoppingOffers = function(price, special, needs) {
    const n = price.length;
    let minCost = Infinity;

    const backtrack = (needs, currentCost) => {
        let totalCost = currentCost;
        for (let i = 0; i < n; i++) {
            totalCost += needs[i] * price[i];
        }
        minCost = Math.min(minCost, totalCost);

        for (const offer of special) {
            let nextNeeds = [...needs];
            let valid = true;
            for (let i = 0; i < n; i++) {
                nextNeeds[i] -= offer[i];
                if (nextNeeds[i] < 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                backtrack(nextNeeds, currentCost + offer[n]);
            }
        }
    };

    backtrack(needs, 0);
    return minCost;
};