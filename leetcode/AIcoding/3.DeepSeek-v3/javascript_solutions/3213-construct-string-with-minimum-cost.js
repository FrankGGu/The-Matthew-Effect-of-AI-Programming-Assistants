var minCost = function(s, costs) {
    let totalCost = 0;
    let i = 0;
    const n = s.length;

    while (i < n) {
        let j = i;
        let maxCost = costs[i];
        let sumCost = costs[i];

        while (j + 1 < n && s[j] === s[j + 1]) {
            j++;
            sumCost += costs[j];
            maxCost = Math.max(maxCost, costs[j]);
        }

        if (j > i) {
            totalCost += sumCost - maxCost;
        }

        i = j + 1;
    }

    return totalCost;
};