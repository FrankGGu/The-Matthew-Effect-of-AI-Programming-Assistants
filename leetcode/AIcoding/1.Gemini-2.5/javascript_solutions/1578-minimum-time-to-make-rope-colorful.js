var minCost = function(colors, neededTime) {
    let minTime = 0;
    let n = colors.length;

    if (n <= 1) {
        return 0;
    }

    let currentGroupSum = neededTime[0];
    let currentGroupMax = neededTime[0];

    for (let i = 1; i < n; i++) {
        if (colors[i] === colors[i - 1]) {
            currentGroupSum += neededTime[i];
            currentGroupMax = Math.max(currentGroupMax, neededTime[i]);
        } else {
            minTime += (currentGroupSum - currentGroupMax);
            currentGroupSum = neededTime[i];
            currentGroupMax = neededTime[i];
        }
    }

    // Add the cost for the last group
    minTime += (currentGroupSum - currentGroupMax);

    return minTime;
};