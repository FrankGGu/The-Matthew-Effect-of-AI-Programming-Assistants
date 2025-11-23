var maxRepeating = function(sequence, word) {
    let count = 0;
    let currentRepeat = word;

    while (sequence.includes(currentRepeat)) {
        count++;
        currentRepeat += word;
    }

    return count;
};