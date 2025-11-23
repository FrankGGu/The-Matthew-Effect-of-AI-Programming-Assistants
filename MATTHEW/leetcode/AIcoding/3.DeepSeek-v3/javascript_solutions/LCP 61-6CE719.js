var temperatureTrend = function(temperatureA, temperatureB) {
    let trendA = [];
    let trendB = [];
    for (let i = 1; i < temperatureA.length; i++) {
        if (temperatureA[i] > temperatureA[i-1]) {
            trendA.push(1);
        } else if (temperatureA[i] < temperatureA[i-1]) {
            trendA.push(-1);
        } else {
            trendA.push(0);
        }
        if (temperatureB[i] > temperatureB[i-1]) {
            trendB.push(1);
        } else if (temperatureB[i] < temperatureB[i-1]) {
            trendB.push(-1);
        } else {
            trendB.push(0);
        }
    }
    let maxLen = 0;
    let currentLen = 0;
    for (let i = 0; i < trendA.length; i++) {
        if (trendA[i] === trendB[i]) {
            currentLen++;
            maxLen = Math.max(maxLen, currentLen);
        } else {
            currentLen = 0;
        }
    }
    return maxLen;
};