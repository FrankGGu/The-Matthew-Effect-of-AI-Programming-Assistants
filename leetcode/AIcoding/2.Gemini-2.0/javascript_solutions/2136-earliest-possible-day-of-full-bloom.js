var earliestFullBloom = function(plantTime, growTime) {
    const n = plantTime.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => growTime[b] - growTime[a]);

    let bloomDay = 0;
    let plantComplete = 0;

    for (let i = 0; i < n; i++) {
        const index = indices[i];
        plantComplete += plantTime[index];
        bloomDay = Math.max(bloomDay, plantComplete + growTime[index]);
    }

    return bloomDay;
};