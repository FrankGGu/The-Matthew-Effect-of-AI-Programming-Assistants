var numberOfPoints = function(cars) {
    if (cars.length === 0) {
        return 0;
    }

    cars.sort((a, b) => a[0] - b[0]);

    let mergedIntervals = [];
    mergedIntervals.push(cars[0]);

    for (let i = 1; i < cars.length; i++) {
        let currentCar = cars[i];
        let lastMerged = mergedIntervals[mergedIntervals.length - 1];

        if (currentCar[0] <= lastMerged[1] + 1) {
            lastMerged[1] = Math.max(lastMerged[1], currentCar[1]);
        } else {
            mergedIntervals.push(currentCar);
        }
    }

    let totalPoints = 0;
    for (let i = 0; i < mergedIntervals.length; i++) {
        let interval = mergedIntervals[i];
        totalPoints += (interval[1] - interval[0] + 1);
    }

    return totalPoints;
};