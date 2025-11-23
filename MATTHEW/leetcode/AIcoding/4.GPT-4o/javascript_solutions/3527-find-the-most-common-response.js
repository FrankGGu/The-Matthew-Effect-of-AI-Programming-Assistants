function mostCommonResponse(responses) {
    const count = {};
    let maxCount = 0;
    let mostCommon = '';

    for (const response of responses) {
        count[response] = (count[response] || 0) + 1;
        if (count[response] > maxCount) {
            maxCount = count[response];
            mostCommon = response;
        }
    }

    return mostCommon;
}