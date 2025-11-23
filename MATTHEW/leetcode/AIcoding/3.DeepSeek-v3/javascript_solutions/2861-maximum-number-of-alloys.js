var maxNumberOfAlloys = function(n, k, budget, composition, stock, cost) {
    let left = 0;
    let right = 200000000;
    let answer = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        let isValid = false;

        for (const comp of composition) {
            let totalCost = 0;
            for (let i = 0; i < n; i++) {
                const needed = Math.max(0, comp[i] * mid - stock[i]);
                totalCost += needed * cost[i];
                if (totalCost > budget) {
                    break;
                }
            }
            if (totalCost <= budget) {
                isValid = true;
                break;
            }
        }

        if (isValid) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return answer;
};