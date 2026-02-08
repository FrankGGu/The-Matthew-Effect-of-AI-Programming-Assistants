var lastVisitedIntegers = function(words) {
    const visitedNumbers = [];
    const result = [];
    let consecutivePrevCount = 0;

    for (const word of words) {
        if (word === "prev") {
            consecutivePrevCount++;
            if (consecutivePrevCount <= visitedNumbers.length) {
                result.push(visitedNumbers[visitedNumbers.length - consecutivePrevCount]);
            } else {
                result.push(-1);
            }
        } else {
            visitedNumbers.push(parseInt(word));
            consecutivePrevCount = 0;
        }
    }

    return result;
};