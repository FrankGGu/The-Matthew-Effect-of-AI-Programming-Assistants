var shoppingOffers = function(price, special, needs) {
    let minCost = Infinity;

    function calculateCost(currentNeeds, currentCost) {
        let isSatisfied = true;
        for (let i = 0; i < currentNeeds.length; i++) {
            if (currentNeeds[i] < 0) {
                return;
            }
            if (currentNeeds[i] > 0) {
                isSatisfied = false;
            }
        }

        if (isSatisfied) {
            minCost = Math.min(minCost, currentCost);
            return;
        }

        let allZero = true;
        for(let i = 0; i < currentNeeds.length; i++) {
            if(currentNeeds[i] > 0) {
                allZero = false;
                break;
            }
        }

        if(allZero) {
            minCost = Math.min(minCost, currentCost);
            return;
        }

        for (let offer of special) {
            let newNeeds = [...currentNeeds];
            let validOffer = true;
            for (let i = 0; i < newNeeds.length; i++) {
                newNeeds[i] -= offer[i];
                if (newNeeds[i] < 0) {
                    validOffer = false;
                    break;
                }
            }

            if (validOffer) {
                calculateCost(newNeeds, currentCost + offer[offer.length - 1]);
            }
        }

        let directCost = 0;
        for (let i = 0; i < currentNeeds.length; i++) {
            directCost += currentNeeds[i] * price[i];
        }
        minCost = Math.min(minCost, currentCost + directCost);
    }

    calculateCost(needs, 0);
    return minCost;
};