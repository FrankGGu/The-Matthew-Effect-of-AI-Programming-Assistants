var capitalizeTitle = function(s) {
    const words = s.split(' ');
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word.length === 1) {
            words[i] = word.toUpperCase();
        } else {
            words[i] = word[0].toUpperCase() + word.slice(1).toLowerCase();
        }
    }
    return words.join(' ');
};