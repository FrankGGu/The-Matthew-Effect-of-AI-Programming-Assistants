var closeStrings = function(word1, word2) {
    if (word1.length !== word2.length) return false;

    const count1 = Array(26).fill(0);
    const count2 = Array(26).fill(0);

    for (let char of word1) count1[char.charCodeAt() - 97]++;
    for (let char of word2) count2[char.charCodeAt() - 97]++;

    const freq1 = count1.filter(c => c > 0).sort((a, b) => a - b);
    const freq2 = count2.filter(c => c > 0).sort((a, b) => a - b);

    return freq1.toString() === freq2.toString() && 
           count1.some(c => c > 0) === count2.some(c => c > 0);
};