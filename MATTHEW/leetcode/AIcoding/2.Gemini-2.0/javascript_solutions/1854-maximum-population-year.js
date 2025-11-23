var maximumPopulation = function(logs) {
    const years = {};
    for (const log of logs) {
        const birth = log[0];
        const death = log[1];
        for (let i = birth; i < death; i++) {
            years[i] = (years[i] || 0) + 1;
        }
    }

    let maxPopulation = 0;
    let maxYear = 0;
    for (const year in years) {
        if (years[year] > maxPopulation) {
            maxPopulation = years[year];
            maxYear = parseInt(year);
        } else if (years[year] === maxPopulation && parseInt(year) < maxYear) {
            maxYear = parseInt(year);
        }
    }

    return maxYear;
};