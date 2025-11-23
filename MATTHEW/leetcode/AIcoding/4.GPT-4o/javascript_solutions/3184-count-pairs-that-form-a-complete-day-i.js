var countPairs = function(dates) {
    let count = 0;
    const seen = new Set();

    for (const date of dates) {
        const complement = 24 - date;
        if (seen.has(complement)) {
            count++;
        }
        seen.add(date);
    }

    return count;
};