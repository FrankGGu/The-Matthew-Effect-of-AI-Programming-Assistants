var garbageCollection = function(garbage, travel) {
    let totalTime = 0;
    let lastM = -1;
    let lastP = -1;
    let lastG = -1;

    for (let i = 0; i < garbage.length; i++) {
        totalTime += garbage[i].length; // Add pickup time for current house

        if (garbage[i].includes('M')) {
            lastM = i;
        }
        if (garbage[i].includes('P')) {
            lastP = i;
        }
        if (garbage[i].includes('G')) {
            lastG = i;
        }
    }

    let currentTravelSum = 0;
    for (let j = 0; j < travel.length; j++) {
        currentTravelSum += travel[j];

        if (j === lastM - 1) {
            totalTime += currentTravelSum;
        }
        if (j === lastP - 1) {
            totalTime += currentTravelSum;
        }
        if (j === lastG - 1) {
            totalTime += currentTravelSum;
        }
    }

    return totalTime;
};