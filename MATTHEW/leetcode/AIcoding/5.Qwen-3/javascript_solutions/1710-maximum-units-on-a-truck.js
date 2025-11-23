function maximumUnits(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);
    let totalUnits = 0;
    for (let i = 0; i < boxTypes.length && truckSize > 0; i++) {
        const [boxes, units] = boxTypes[i];
        const take = Math.min(boxes, truckSize);
        totalUnits += take * units;
        truckSize -= take;
    }
    return totalUnits;
}