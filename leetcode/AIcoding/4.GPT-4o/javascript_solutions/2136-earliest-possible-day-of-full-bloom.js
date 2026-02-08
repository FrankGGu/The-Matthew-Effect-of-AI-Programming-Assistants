var earliestFullBloom = function(plants, growTime) {
    const n = plants.length;
    const plantsWithGrowTime = plants.map((p, i) => [p, growTime[i]]);
    plantsWithGrowTime.sort((a, b) => b[1] - a[1]);

    let currentDay = 0;
    let maxBloomDay = 0;

    for (const [plant, growth] of plantsWithGrowTime) {
        currentDay += plant;
        maxBloomDay = Math.max(maxBloomDay, currentDay + growth);
    }

    return maxBloomDay;
};