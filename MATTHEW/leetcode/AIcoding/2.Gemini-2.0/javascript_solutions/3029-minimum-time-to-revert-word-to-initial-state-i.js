var minimumTimeToInitialState = function(word) {
    let n = word.length;
    let k = 1;
    let count = 0;
    while (k * k < n) {
        k++;
    }
    let shiftedWord = word.substring(k);
    while (shiftedWord.length > 0) {
        count++;
        if (word.startsWith(shiftedWord)) {
            return count;
        }
        shiftedWord = word.substring(k * (count + 1));
    }
    return count;
};