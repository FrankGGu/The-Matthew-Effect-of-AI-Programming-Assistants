var maxRepeating = function(sequence, word) {
    let count = 0;
    let repeatedWord = word;
    while (sequence.includes(repeatedWord)) {
        count++;
        repeatedWord += word;
    }
    return count;
};