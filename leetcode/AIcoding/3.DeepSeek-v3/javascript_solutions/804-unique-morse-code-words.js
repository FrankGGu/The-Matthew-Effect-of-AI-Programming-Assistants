var uniqueMorseRepresentations = function(words) {
    const morseCodes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."];
    const transformations = new Set();

    for (const word of words) {
        let morse = '';
        for (const char of word) {
            const index = char.charCodeAt(0) - 'a'.charCodeAt(0);
            morse += morseCodes[index];
        }
        transformations.add(morse);
    }

    return transformations.size;
};