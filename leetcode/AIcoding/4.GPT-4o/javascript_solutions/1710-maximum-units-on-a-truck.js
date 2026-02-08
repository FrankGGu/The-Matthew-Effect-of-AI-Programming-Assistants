var maximumUnits = function(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);
    let totalUnits = 0;
    for (let [boxes, units] of boxTypes) {
        if (truckSize <= 0) break;
        const takeBoxes = Math.min(boxes, truckSize);
        totalUnits += takeBoxes * units;
        truckSize -= takeBoxes;
    }
    return totalUnits;
};