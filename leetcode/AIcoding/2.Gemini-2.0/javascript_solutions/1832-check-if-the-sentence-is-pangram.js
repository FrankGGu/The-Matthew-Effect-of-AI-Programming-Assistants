var checkIfPangram = function(sentence) {
    const alphabet = 'abcdefghijklmnopqrstuvwxyz';
    for (let char of alphabet) {
        if (!sentence.includes(char)) {
            return false;
        }
    }
    return true;
};