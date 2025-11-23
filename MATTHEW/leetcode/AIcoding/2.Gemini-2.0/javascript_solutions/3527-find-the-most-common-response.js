var mostCommonResponse = function(responses) {
    const counts = {};
    let maxCount = 0;
    let mostCommon = "";

    for (const response of responses) {
        counts[response] = (counts[response] || 0) + 1;
        if (counts[response] > maxCount) {
            maxCount = counts[response];
            mostCommon = response;
        }
    }

    return mostCommon;
};