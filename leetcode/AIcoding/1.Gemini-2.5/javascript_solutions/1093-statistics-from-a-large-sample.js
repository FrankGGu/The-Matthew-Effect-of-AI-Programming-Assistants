var statisticsFromLargeSample = function(count) {
    let minVal = 256;
    let maxVal = -1;
    let totalSum = 0;
    let totalCount = 0;
    let modeVal = 0;
    let maxFreq = 0;

    for (let x = 0; x <= 255; x++) {
        if (count[x] > 0) {
            if (minVal === 256) { // First number found
                minVal = x;
            }
            maxVal = x; // This will be the largest x with count > 0 by the end

            totalSum += x * count[x];
            totalCount += count[x];

            if (count[x] > maxFreq) {
                maxFreq = count[x];
                modeVal = x;
            }
        }
    }

    const mean = totalSum / totalCount;

    let median1 = 0;
    let median2 = 0;
    let currentCumulativeCount = 0;

    const target1 = Math.floor((totalCount - 1) / 2);
    const target2 = Math.floor(totalCount / 2);

    for (let x = 0; x <= 255; x++) {
        currentCumulativeCount += count[x];

        if (median1 === 0 && currentCumulativeCount > target1) {
            median1 = x;
        }
        if (median2 === 0 && currentCumulativeCount > target2) {
            median2 = x;
        }

        if (median1 !== 0 && median2 !== 0) {
            break; 
        }
    }

    const median = (median1 + median2) / 2;

    return [minVal, maxVal, mean, median, modeVal];
};