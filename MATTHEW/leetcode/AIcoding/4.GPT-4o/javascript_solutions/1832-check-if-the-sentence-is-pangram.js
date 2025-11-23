var checkIfPangram = function(sentence) {
    const alphabetSet = new Set();
    for (let char of sentence) {
        alphabetSet.add(char);
    }
    return alphabetSet.size === 26;
};