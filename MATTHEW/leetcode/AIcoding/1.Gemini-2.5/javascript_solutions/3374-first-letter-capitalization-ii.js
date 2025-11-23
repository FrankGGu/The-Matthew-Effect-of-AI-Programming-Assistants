var capitalizeTitle = function(s) {
    const words = s.split(' ');
    const resultWords = [];

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word.length <= 2) {
            resultWords.push(word.toLowerCase());
        } else {
            resultWords.push(word.charAt(0).toUpperCase() + word.slice(1).toLowerCase());
        }
    }

    return resultWords.join(' ');
};