var minCost = function(colors, neededTime) {
    let totalTime = 0;
    let maxTime = neededTime[0];
    let sumTime = neededTime[0];

    for (let i = 1; i < colors.length; i++) {
        if (colors[i] === colors[i - 1]) {
            maxTime = Math.max(maxTime, neededTime[i]);
            sumTime += neededTime[i];
        } else {
            totalTime += sumTime - maxTime;
            maxTime = neededTime[i];
            sumTime = neededTime[i];
        }
    }
    totalTime += sumTime - maxTime;

    return totalTime;
};