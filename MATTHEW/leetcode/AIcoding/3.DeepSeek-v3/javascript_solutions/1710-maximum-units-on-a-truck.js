var maximumUnits = function(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);
    let totalUnits = 0;
    let remaining = truckSize;

    for (const [boxes, units] of boxTypes) {
        if (remaining <= 0) break;
        const taken = Math.min(boxes, remaining);
        totalUnits += taken * units;
        remaining -= taken;
    }

    return totalUnits;
};