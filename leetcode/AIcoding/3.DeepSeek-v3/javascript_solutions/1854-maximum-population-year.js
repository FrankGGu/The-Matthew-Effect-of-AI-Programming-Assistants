var maximumPopulation = function(logs) {
    const years = new Array(101).fill(0); // 1950 to 2050

    for (const [birth, death] of logs) {
        years[birth - 1950]++;
        years[death - 1950]--;
    }

    let maxPopulation = years[0];
    let maxYear = 1950;

    for (let i = 1; i < years.length; i++) {
        years[i] += years[i - 1];
        if (years[i] > maxPopulation) {
            maxPopulation = years[i];
            maxYear = i + 1950;
        }
    }

    return maxYear;
};