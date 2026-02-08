var maximumPopulation = function(logs) {
    const yearCount = new Array(2051).fill(0);

    for (const [birth, death] of logs) {
        yearCount[birth]++;
        yearCount[death]--;
    }

    let maxPopulation = 0;
    let yearWithMaxPopulation = 0;
    let currentPopulation = 0;

    for (let year = 1950; year <= 2050; year++) {
        currentPopulation += yearCount[year];
        if (currentPopulation > maxPopulation) {
            maxPopulation = currentPopulation;
            yearWithMaxPopulation = year;
        }
    }

    return yearWithMaxPopulation;
};