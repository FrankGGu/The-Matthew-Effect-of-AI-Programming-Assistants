var temperatureTrend = function(temperatureChanges) {
    let maxTrend = 0;
    let currentTrend = 0;

    for (let i = 1; i < temperatureChanges.length; i++) {
        let prev = temperatureChanges[i - 1];
        let curr = temperatureChanges[i];

        if (curr > prev) {
            currentTrend++;
        } else if (curr < prev) {
            currentTrend++;
        } else {
            currentTrend++;
        }

        maxTrend = Math.max(maxTrend, currentTrend);

        if (curr > prev) {
            // Do nothing
        } else if (curr < prev) {
            // Do nothing
        } else {
            // Do nothing
        }
    }

    currentTrend = 0;
    for (let i = 1; i < temperatureChanges.length; i++) {
        let prev = temperatureChanges[i - 1];
        let curr = temperatureChanges[i];
        let trendPrev;
        let trendCurr;

        if (temperatureChanges[i-1] < temperatureChanges[i]) {
            trendPrev = 1;
        } else if (temperatureChanges[i-1] > temperatureChanges[i]) {
            trendPrev = -1;
        } else {
            trendPrev = 0;
        }

        if (temperatureChanges[i] < temperatureChanges[i-1]) {
            trendCurr = -1;
        } else if (temperatureChanges[i] > temperatureChanges[i-1]) {
            trendCurr = 1;
        } else {
            trendCurr = 0;
        }

        if (trendPrev === trendCurr) {
            currentTrend++;
            maxTrend = Math.max(maxTrend, currentTrend);
        } else {
            currentTrend = 0;
        }
    }

    return maxTrend;
};