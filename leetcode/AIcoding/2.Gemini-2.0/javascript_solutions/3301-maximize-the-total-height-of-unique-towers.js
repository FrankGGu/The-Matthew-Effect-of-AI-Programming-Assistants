var maximizeTheTowers = function(quantity, limit) {
    quantity.sort((a, b) => b - a);
    let n = quantity.length;
    let towers = [];
    let totalHeight = 0;

    for (let i = 0; i < n; i++) {
        let count = quantity[i];
        let added = false;
        for (let j = 0; j < towers.length; j++) {
            if (towers[j] < limit) {
                let add = Math.min(limit - towers[j], count);
                towers[j] += add;
                count -= add;
                totalHeight += add;
                if (count === 0) {
                    added = true;
                    break;
                }
            }
        }
        if (!added) {
            let newTowersNeeded = Math.ceil(count / limit);
            for (let k = 0; k < newTowersNeeded; k++) {
                let add = Math.min(limit, count);
                towers.push(add);
                totalHeight += add;
                count -= add;
            }
        }
    }

    return totalHeight;
};