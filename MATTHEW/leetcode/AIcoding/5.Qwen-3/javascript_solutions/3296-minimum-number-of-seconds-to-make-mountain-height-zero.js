function minTimeToMakeMountainZero(colors, neededTime) {
    let total = 0;
    let prev = 0;
    for (let i = 1; i < colors.length; i++) {
        if (colors[i] === colors[i - 1]) {
            if (neededTime[i] > neededTime[prev]) {
                total += neededTime[i] - neededTime[prev];
                prev = i;
            } else {
                total += neededTime[i];
            }
        } else {
            prev = i;
        }
    }
    return total;
}