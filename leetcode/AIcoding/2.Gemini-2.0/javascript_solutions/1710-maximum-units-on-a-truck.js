var maximumUnits = function(boxTypes, truckSize) {
    boxTypes.sort((a, b) => b[1] - a[1]);
    let units = 0;
    for (let i = 0; i < boxTypes.length; i++) {
        let boxes = boxTypes[i][0];
        let unitPerBox = boxTypes[i][1];
        if (truckSize >= boxes) {
            units += boxes * unitPerBox;
            truckSize -= boxes;
        } else {
            units += truckSize * unitPerBox;
            truckSize = 0;
            break;
        }
    }
    return units;
};