var capitalizeTitle = function(title) {
    const words = title.split(" ");
    const capitalizedWords = words.map(word => {
        const lowerCaseWord = word.toLowerCase();
        if (lowerCaseWord.length <= 2) {
            return lowerCaseWord;
        } else {
            return lowerCaseWord.charAt(0).toUpperCase() + lowerCaseWord.slice(1);
        }
    });
    return capitalizedWords.join(" ");
};