var vowelStrings = function(words, left, right) {
    const isVowelString = (s) => {
        return 'aeiou'.includes(s[0]) && 'aeiou'.includes(s[s.length - 1]);
    };

    let count = 0;
    for (let i = left; i <= right; i++) {
        if (isVowelString(words[i])) {
            count++;
        }
    }
    return count;
};