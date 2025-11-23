var findRadius = function(houses, heaters) {
    houses.sort((a, b) => a - b);
    heaters.sort((a, b) => a - b);

    let maxMinRadius = 0;
    let heaterIdx = 0;

    for (let i = 0; i < houses.length; i++) {
        let currentHouse = houses[i];

        while (heaterIdx < heaters.length - 1 && 
               Math.abs(heaters[heaterIdx + 1] - currentHouse) <= Math.abs(heaters[heaterIdx] - currentHouse)) {
            heaterIdx++;
        }

        maxMinRadius = Math.max(maxMinRadius, Math.abs(heaters[heaterIdx] - currentHouse));
    }

    return maxMinRadius;
};