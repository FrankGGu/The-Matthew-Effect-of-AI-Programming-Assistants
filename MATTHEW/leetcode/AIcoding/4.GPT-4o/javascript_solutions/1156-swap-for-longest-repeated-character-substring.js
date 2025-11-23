var maximumRep = function(s) {
    let maxCount = 0;
    let charCount = new Array(26).fill(0);
    let n = s.length;

    for (let i = 0; i < n; i++) {
        charCount[s[i].charCodeAt() - 'a'.charCodeAt()]++;
        maxCount = Math.max(maxCount, charCount[s[i].charCodeAt() - 'a'.charCodeAt()]);
    }

    for (let i = 0; i < n; i++) {
        let currentChar = s[i];
        let currentCount = charCount[currentChar.charCodeAt() - 'a'.charCodeAt()];

        if (currentCount === maxCount) {
            charCount[currentChar.charCodeAt() - 'a'.charCodeAt()]--;
            for (let j = 0; j < 26; j++) {
                if (charCount[j] === maxCount) {
                    charCount[currentChar.charCodeAt() - 'a'.charCodeAt()]++;
                    return maxCount + 1;
                }
            }
            charCount[currentChar.charCodeAt() - 'a'.charCodeAt()]++;
        }
    }

    return maxCount;
};