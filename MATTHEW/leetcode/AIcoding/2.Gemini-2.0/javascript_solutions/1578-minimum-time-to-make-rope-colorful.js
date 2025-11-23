var minCost = function(colors, neededTime) {
    let totalCost = 0;
    let i = 0;
    while (i < colors.length - 1) {
        let j = i;
        let maxTime = 0;
        let groupCost = 0;
        while (j < colors.length && colors[i] === colors[j]) {
            maxTime = Math.max(maxTime, neededTime[j]);
            groupCost += neededTime[j];
            j++;
        }
        totalCost += (groupCost - maxTime);
        i = j;
    }
    return totalCost;
};