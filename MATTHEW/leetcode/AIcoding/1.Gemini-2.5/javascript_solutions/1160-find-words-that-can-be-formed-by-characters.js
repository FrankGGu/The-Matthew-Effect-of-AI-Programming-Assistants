var countCharacters = function(words, chars) {
    const charFreq = new Array(26).fill(0);
    for (let i = 0; i < chars.length; i++) {
        charFreq[chars.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let totalLength = 0;

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const wordFreq = new Array(26).fill(0);
        let canForm = true;

        for (let j = 0; j < word.length; j++) {
            const charCode = word.charCodeAt(j) - 'a'.charCodeAt(0);
            wordFreq[charCode]++;
            if (wordFreq[charCode] > charFreq[charCode]) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            totalLength += word.length;
        }
    }

    return totalLength;
};