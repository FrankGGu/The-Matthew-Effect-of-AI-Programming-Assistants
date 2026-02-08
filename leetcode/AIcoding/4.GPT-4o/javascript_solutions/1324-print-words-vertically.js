var printVertically = function(s) {
    const words = s.split(' ');
    const maxLength = Math.max(...words.map(word => word.length));
    const result = [];

    for (let i = 0; i < maxLength; i++) {
        let verticalWord = '';
        for (let j = 0; j < words.length; j++) {
            if (i < words[j].length) {
                verticalWord += words[j][i];
            } else {
                verticalWord += ' ';
            }
        }
        result.push(verticalWord.trimEnd());
    }

    return result;
};