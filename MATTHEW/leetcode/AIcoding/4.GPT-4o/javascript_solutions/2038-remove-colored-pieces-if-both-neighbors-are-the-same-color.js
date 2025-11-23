var removeColoredPieces = function(colors, neededTime) {
    let totalTime = 0;
    let maxTime = 0;

    for (let i = 0; i < colors.length; i++) {
        if (i > 0 && colors[i] === colors[i - 1]) {
            totalTime += Math.min(neededTime[i], neededTime[i - 1]);
            maxTime = Math.max(maxTime, Math.max(neededTime[i], neededTime[i - 1]));
        }
    }

    return totalTime + maxTime;
};