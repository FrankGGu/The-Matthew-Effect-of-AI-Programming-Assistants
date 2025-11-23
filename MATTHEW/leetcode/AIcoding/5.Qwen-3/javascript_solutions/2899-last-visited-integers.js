function getLastVisitedIntegers(words) {
    const result = [];
    let count = 0;

    for (const word of words) {
        if (/^\d+$/.test(word)) {
            count++;
            result.push(parseInt(word, 10));
        } else {
            count = 0;
        }
    }

    return result;
}