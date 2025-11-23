function maxActiveSections(trades) {
    let activeSections = 0;
    let maxSections = 0;

    for (let trade of trades) {
        if (trade === 1) {
            activeSections++;
        } else {
            activeSections--;
        }
        maxSections = Math.max(maxSections, activeSections);
    }

    return maxSections;
}