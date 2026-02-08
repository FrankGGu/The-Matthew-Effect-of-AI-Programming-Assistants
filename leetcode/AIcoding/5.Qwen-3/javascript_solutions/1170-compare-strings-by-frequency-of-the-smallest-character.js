function numSmallerByFrequency(words, s) {
    function f(word) {
        let count = 0;
        let minChar = word[0];
        for (let char of word) {
            if (char < minChar) {
                minChar = char;
                count = 1;
            } else if (char === minChar) {
                count++;
            }
        }
        return count;
    }

    const sCount = f(s);
    let result = 0;

    for (let word of words) {
        if (f(word) < sCount) {
            result++;
        }
    }

    return result;
}