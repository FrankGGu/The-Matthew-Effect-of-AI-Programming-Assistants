var maximumUnits = function(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);

    let totalUnits = 0;
    for (let i = 0; i < boxTypes.length; i++) {
        const [numberOfBoxes, unitsPerBox] = boxTypes[i];

        if (truckSize <= 0) {
            break;
        }

        const boxesToTake = Math.min(numberOfBoxes, truckSize);
        totalUnits += boxesToTake * unitsPerBox;
        truckSize -= boxesToTake;
    }

    return totalUnits;
};