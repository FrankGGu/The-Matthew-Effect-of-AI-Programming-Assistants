var maxDistance = function(arrays) {
    let maxDist = 0;

    let minValOverallSoFar = arrays[0][0];
    let maxValOverallSoFar = arrays[0][arrays[0].length - 1];

    for (let i = 1; i < arrays.length; i++) {
        const currentMin = arrays[i][0];
        const currentMax = arrays[i][arrays[i].length - 1];

        maxDist = Math.max(maxDist, Math.abs(currentMax - minValOverallSoFar));
        maxDist = Math.max(maxDist, Math.abs(maxValOverallSoFar - currentMin));

        minValOverallSoFar = Math.min(minValOverallSoFar, currentMin);
        maxValOverallSoFar = Math.max(maxValOverallSoFar, currentMax);
    }

    return maxDist;
};