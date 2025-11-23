var removeAnagrams = function(words) {
    const isAnagram = (a, b) => {
        if (a.length !== b.length) return false;
        const count = new Array(26).fill(0);
        for (let i = 0; i < a.length; i++) {
            count[a.charCodeAt(i) - 'a'.charCodeAt(0)]++;
            count[b.charCodeAt(i) - 'a'.charCodeAt(0)]--;
        }
        return count.every(c => c === 0);
    };

    let i = 1;
    while (i < words.length) {
        if (isAnagram(words[i - 1], words[i])) {
            words.splice(i, 1);
        } else {
            i++;
        }
    }
    return words;
};