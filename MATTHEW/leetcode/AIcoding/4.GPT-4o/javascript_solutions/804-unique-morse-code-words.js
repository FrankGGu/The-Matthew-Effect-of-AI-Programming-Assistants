var uniqueMorseRepresentations = function(words) {
    const morseCode = [
        ".-", "-...", "-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."
    ];

    const uniqueMorse = new Set();

    for (const word of words) {
        let morseWord = '';
        for (const char of word) {
            morseWord += morseCode[char.charCodeAt(0) - 'a'.charCodeAt(0)];
        }
        uniqueMorse.add(morseWord);
    }

    return uniqueMorse.size;
};