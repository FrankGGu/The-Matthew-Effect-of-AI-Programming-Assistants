var minimumTimeToCollectGarbage = function(garbage, travel) {
    let totalTime = 0;
    let lastIndex = { 'M': -1, 'P': -1, 'G': -1 };

    for (let i = 0; i < garbage.length; i++) {
        totalTime += garbage[i].length;
        if (garbage[i].includes('M')) lastIndex['M'] = i;
        if (garbage[i].includes('P')) lastIndex['P'] = i;
        if (garbage[i].includes('G')) lastIndex['G'] = i;
    }

    for (let type of ['M', 'P', 'G']) {
        if (lastIndex[type] !== -1) {
            totalTime += travel.slice(0, lastIndex[type]).reduce((a, b) => a + b, 0);
        }
    }

    return totalTime;
};