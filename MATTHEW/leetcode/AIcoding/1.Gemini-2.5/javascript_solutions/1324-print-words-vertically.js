var printVertically = function(s) {
    const words = s.split(' ');
    let maxLength = 0;
    for (const word of words) {
        maxLength = Math.max(maxLength, word.length);
    }

    const result = new Array(maxLength).fill('');

    for (let j = 0; j < maxLength; j++) {
        for (let i = 0; i < words.length; i++) {
            const word = words[i];
            if (j < word.length) {
                result[j] += word[j];
            } else {
                result[j] += ' ';
            }
        }
    }

    for (let k = 0; k < result.length; k++) {
        result[k] = result[k].trimEnd();
    }

    return result;
};