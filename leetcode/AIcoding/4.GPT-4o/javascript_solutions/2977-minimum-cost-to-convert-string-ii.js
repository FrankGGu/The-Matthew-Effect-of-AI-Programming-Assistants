var minimumCost = function(s1, s2, cost) {
    let totalCost = 0;
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            totalCost += cost[i];
        }
    }
    return totalCost;
};