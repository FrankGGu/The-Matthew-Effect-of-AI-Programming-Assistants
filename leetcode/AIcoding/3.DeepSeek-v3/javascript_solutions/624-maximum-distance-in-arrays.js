var maxDistance = function(arrays) {
    let min = arrays[0][0];
    let max = arrays[0][arrays[0].length - 1];
    let res = 0;

    for (let i = 1; i < arrays.length; i++) {
        const currentFirst = arrays[i][0];
        const currentLast = arrays[i][arrays[i].length - 1];
        res = Math.max(res, Math.abs(currentLast - min), Math.abs(max - currentFirst));
        min = Math.min(min, currentFirst);
        max = Math.max(max, currentLast);
    }

    return res;
};