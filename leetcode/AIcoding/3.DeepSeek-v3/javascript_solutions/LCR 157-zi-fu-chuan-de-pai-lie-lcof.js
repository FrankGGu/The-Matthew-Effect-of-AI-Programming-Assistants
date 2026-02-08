var shoppingOffers = function(price, special, needs) {
    const memo = new Map();

    function dfs(currentNeeds) {
        const key = currentNeeds.join(',');
        if (memo.has(key)) return memo.get(key);

        let minCost = 0;
        for (let i = 0; i < currentNeeds.length; i++) {
            minCost += currentNeeds[i] * price[i];
        }

        for (const offer of special) {
            const newNeeds = [...currentNeeds];
            let valid = true;

            for (let i = 0; i < newNeeds.length; i++) {
                if (offer[i] > newNeeds[i]) {
                    valid = false;
                    break;
                }
                newNeeds[i] -= offer[i];
            }

            if (valid) {
                const cost = offer[offer.length - 1] + dfs(newNeeds);
                if (cost < minCost) {
                    minCost = cost;
                }
            }
        }

        memo.set(key, minCost);
        return minCost;
    }

    return dfs(needs);
};