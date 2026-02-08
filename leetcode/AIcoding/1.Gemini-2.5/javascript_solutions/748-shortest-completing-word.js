var shortestCompletingWord = function(licensePlate, words) {
    const getCharCounts = (str) => {
        const counts = new Array(26).fill(0);
        for (let i = 0; i < str.length; i++) {
            const char = str[i].toLowerCase();
            if (char >= 'a' && char <= 'z') {
                counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            }
        }
        return counts;
    };

    const plateCounts = getCharCounts(licensePlate);

    let shortestWord = "";
    let minLength = Infinity;

    for (const word of words) {
        const wordCounts = getCharCounts(word);
        let completes = true;
        for (let i = 0; i < 26; i++) {
            if (plateCounts[i] > wordCounts[i]) {
                completes = false;
                break;
            }
        }

        if (completes) {
            if (word.length < minLength) {
                minLength = word.length;
                shortestWord = word;
            }
        }
    }

    return shortestWord;
};