var shoppingOffers = function(price, needs, special) {
    const n = price.length;

    const isValid = (need) => {
        for (let i = 0; i < n; i++) {
            if (need[i] < 0) {
                return false;
            }
        }
        return true;
    };

    let minCost = Infinity;

    const dfs = (currentNeeds, currentCost) => {
        let costWithoutSpecial = 0;
        for (let i = 0; i < n; i++) {
            costWithoutSpecial += currentNeeds[i] * price[i];
        }
        minCost = Math.min(minCost, currentCost + costWithoutSpecial);

        for (const offer of special) {
            const nextNeeds = currentNeeds.slice();
            let valid = true;
            for (let i = 0; i < n; i++) {
                nextNeeds[i] -= offer[i];
                if (nextNeeds[i] < 0) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                dfs(nextNeeds, currentCost + offer[n]);
            }
        }
    };

    dfs(needs, 0);
    return minCost;
};