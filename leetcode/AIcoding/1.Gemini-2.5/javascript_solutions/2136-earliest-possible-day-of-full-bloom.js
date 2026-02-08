var earliestFullBloom = function(plantTime, growTime) {
    const n = plantTime.length;
    const flowers = [];
    for (let i = 0; i < n; i++) {
        flowers.push({ p: plantTime[i], g: growTime[i] });
    }

    flowers.sort((a, b) => b.g - a.g);

    let currentPlantingTime = 0;
    let maxBloomTime = 0;

    for (const flower of flowers) {
        currentPlantingTime += flower.p;
        maxBloomTime = Math.max(maxBloomTime, currentPlantingTime + flower.g);
    }

    return maxBloomTime;
};