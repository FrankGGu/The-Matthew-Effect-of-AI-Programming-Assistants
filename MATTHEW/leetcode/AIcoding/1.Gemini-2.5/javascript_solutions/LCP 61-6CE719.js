var temperatureTrend = function(temperatures1, temperatures2) {
    let count = 0;
    const n = temperatures1.length;

    const getTrend = (a, b) => {
        if (a < b) {
            return 1;
        } else if (a > b) {
            return -1;
        } else {
            return 0;
        }
    };

    for (let i = 0; i < n - 1; i++) {
        const trend1 = getTrend(temperatures1[i], temperatures1[i + 1]);
        const trend2 = getTrend(temperatures2[i], temperatures2[i + 1]);

        if (trend1 === trend2) {
            count++;
        }
    }

    return count;
};