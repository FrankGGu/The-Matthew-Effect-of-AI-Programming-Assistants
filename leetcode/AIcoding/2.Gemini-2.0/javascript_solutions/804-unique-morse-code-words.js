var uniqueMorseRepresentations = function(words) {
    const morse = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."];
    const transformations = new Set();

    for (const word of words) {
        let morseCode = "";
        for (const char of word) {
            morseCode += morse[char.charCodeAt(0) - 'a'.charCodeAt(0)];
        }
        transformations.add(morseCode);
    }

    return transformations.size;
};