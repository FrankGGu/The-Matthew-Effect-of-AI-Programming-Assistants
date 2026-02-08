var shortestCompletingWord = function(licensePlate, words) {
    let licenseCounts = {};
    for (let char of licensePlate.toLowerCase()) {
        if (/[a-z]/.test(char)) {
            licenseCounts[char] = (licenseCounts[char] || 0) + 1;
        }
    }

    let shortest = null;
    for (let word of words) {
        let wordCounts = {};
        for (let char of word.toLowerCase()) {
            wordCounts[char] = (wordCounts[char] || 0) + 1;
        }

        let complete = true;
        for (let char in licenseCounts) {
            if (!(char in wordCounts) || wordCounts[char] < licenseCounts[char]) {
                complete = false;
                break;
            }
        }

        if (complete) {
            if (shortest === null || word.length < shortest.length) {
                shortest = word;
            }
        }
    }

    return shortest;
};