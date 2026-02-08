var maximumUnits = function(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);

    let totalUnits = 0;
    for (const boxType of boxTypes) {
        const numberOfBoxes = boxType[0];
        const unitsPerBox = boxType[1];

        if (truckSize === 0) {
            break;
        }

        const boxesToLoad = Math.min(truckSize, numberOfBoxes);
        totalUnits += boxesToLoad * unitsPerBox;
        truckSize -= boxesToLoad;
    }

    return totalUnits;
};