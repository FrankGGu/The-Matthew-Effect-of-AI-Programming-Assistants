var canBeRearranged = function(words, s) {
    const count = Array(26).fill(0);
    for (let char of s) {
        count[char.charCodeAt(0) - 97]++;
    }

    const result = [];
    for (let word of words) {
        const tempCount = Array(26).fill(0);
        for (let char of word) {
            tempCount[char.charCodeAt(0) - 97]++;
        }

        let canForm = true;
        for (let i = 0; i < 26; i++) {
            if (tempCount[i] > count[i]) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            result.push(word);
        }
    }

    return result.length;
};