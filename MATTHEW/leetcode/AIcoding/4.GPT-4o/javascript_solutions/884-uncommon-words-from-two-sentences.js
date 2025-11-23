var uncommonFromSentences = function(A, B) {
    const count = {};
    const words = (A + ' ' + B).split(' ');

    for (const word of words) {
        count[word] = (count[word] || 0) + 1;
    }

    return Object.keys(count).filter(word => count[word] === 1);
};