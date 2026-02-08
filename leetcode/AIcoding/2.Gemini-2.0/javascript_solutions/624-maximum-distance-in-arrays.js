var maxDistance = function(arrays) {
    let minVal = arrays[0][0];
    let maxVal = arrays[0][arrays[0].length - 1];
    let maxDistance = 0;

    for (let i = 1; i < arrays.length; i++) {
        let currentMin = arrays[i][0];
        let currentMax = arrays[i][arrays[i].length - 1];

        maxDistance = Math.max(maxDistance, Math.abs(currentMax - minVal), Math.abs(maxVal - currentMin));

        minVal = Math.min(minVal, currentMin);
        maxVal = Math.max(maxVal, currentMax);
    }

    return maxDistance;
};