var numMatchingSubseq = function(s, words) {
    const count = new Array(26).fill(0);
    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const isSubsequence = (word) => {
        let j = 0;
        for (let i = 0; i < s.length && j < word.length; i++) {
            if (s[i] === word[j]) {
                j++;
            }
        }
        return j === word.length;
    };

    let result = 0;
    for (let word of words) {
        if (isSubsequence(word)) {
            result++;
        }
    }

    return result;
};