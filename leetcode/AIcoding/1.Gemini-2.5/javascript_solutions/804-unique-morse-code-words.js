var uniqueMorseRepresentations = function(words) {
    const morseCodeMap = [
        ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."
    ];

    const uniqueRepresentations = new Set();

    for (const word of words) {
        let currentMorse = "";
        for (let i = 0; i < word.length; i++) {
            const charCode = word.charCodeAt(i) - 'a'.charCodeAt(0);
            currentMorse += morseCodeMap[charCode];
        }
        uniqueRepresentations.add(currentMorse);
    }

    return uniqueRepresentations.size;
};