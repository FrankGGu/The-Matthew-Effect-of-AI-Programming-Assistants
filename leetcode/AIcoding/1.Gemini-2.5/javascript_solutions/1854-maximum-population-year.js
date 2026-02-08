var maximumPopulation = function(logs) {
    let population = new Array(101).fill(0); // Years from 1950 to 2050 (inclusive)

    for (let i = 0; i < logs.length; i++) {
        let birth = logs[i][0];
        let death = logs[i][1];

        for (let year = birth; year < death; year++) {
            population[year - 1950]++;
        }
    }

    let maxPop = 0;
    let maxYear = 1950;

    for (let i = 0; i < population.length; i++) {
        if (population[i] > maxPop) {
            maxPop = population[i];
            maxYear = i + 1950;
        }
    }

    return maxYear;
};