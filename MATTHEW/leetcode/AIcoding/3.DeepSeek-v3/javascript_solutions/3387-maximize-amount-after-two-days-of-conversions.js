var maximumAmount = function(amount) {
    let max = 0;
    const n = amount.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const profit = amount[j] - amount[i];
            if (profit > 0) {
                for (let k = j + 1; k < n; k++) {
                    for (let l = k + 1; l < n; l++) {
                        const secondProfit = amount[l] - amount[k];
                        const total = profit + secondProfit;
                        if (total > max) {
                            max = total;
                        }
                    }
                }
            }
        }
    }

    return max;
};