var uniqueMorseRepresentations = function(words) {
    const morseCodes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."];
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    const codeMap = {};
    for (let i = 0; i < letters.length; i++) {
        codeMap[letters[i]] = morseCodes[i];
    }
    const set = new Set();
    for (let word of words) {
        let code = '';
        for (let c of word) {
            code += codeMap[c];
        }
        set.add(code);
    }
    return set.size;
};