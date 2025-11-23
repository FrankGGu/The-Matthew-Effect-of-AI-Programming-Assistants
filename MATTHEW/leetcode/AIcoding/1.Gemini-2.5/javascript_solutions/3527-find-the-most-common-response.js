var mostCommonResponse = function(responses) {
    const counts = new Map();
    for (const response of responses) {
        counts.set(response, (counts.get(response) || 0) + 1);
    }

    let maxCount = 0;
    let mostCommon = "";

    for (const [response, count] of counts.entries()) {
        if (count > maxCount) {
            maxCount = count;
            mostCommon = response;
        } else if (count === maxCount) {
            if (mostCommon === "" || response < mostCommon) {
                mostCommon = response;
            }
        }
    }

    return mostCommon;
};