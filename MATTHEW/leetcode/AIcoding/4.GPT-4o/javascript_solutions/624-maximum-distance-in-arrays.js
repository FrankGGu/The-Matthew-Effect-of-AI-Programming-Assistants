var maxDistance = function(arrays) {
    let min = arrays[0][0], max = arrays[0][arrays[0].length - 1];
    let maxDistance = 0;

    for (let i = 1; i < arrays.length; i++) {
        maxDistance = Math.max(maxDistance, Math.abs(arrays[i][0] - max), Math.abs(arrays[i][arrays[i].length - 1] - min));
        min = Math.min(min, arrays[i][0]);
        max = Math.max(max, arrays[i][arrays[i].length - 1]);
    }

    return maxDistance;
};