var earliestFullBloom = function(plantTime, growTime) {
    const n = plantTime.length;
    const flowers = [];
    for (let i = 0; i < n; i++) {
        flowers.push({ plant: plantTime[i], grow: growTime[i] });
    }

    flowers.sort((a, b) => b.grow - a.grow);

    let totalPlantTime = 0;
    let maxBloomTime = 0;

    for (let i = 0; i < n; i++) {
        const flower = flowers[i];

        totalPlantTime += flower.plant;

        maxBloomTime = Math.max(maxBloomTime, totalPlantTime + flower.grow);
    }

    return maxBloomTime;
};