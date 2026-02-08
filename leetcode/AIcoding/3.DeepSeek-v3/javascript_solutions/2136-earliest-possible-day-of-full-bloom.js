var earliestFullBloom = function(plantTime, growTime) {
    const n = plantTime.length;
    let indices = Array.from({length: n}, (_, i) => i);
    indices.sort((a, b) => growTime[b] - growTime[a]);

    let res = 0;
    let currentPlantTime = 0;

    for (let i of indices) {
        currentPlantTime += plantTime[i];
        res = Math.max(res, currentPlantTime + growTime[i]);
    }

    return res;
};