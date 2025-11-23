var isItPossible = function(word1, word2, maxCost) {
    const count1 = Array(26).fill(0);
    const count2 = Array(26).fill(0);

    for (const char of word1) count1[char.charCodeAt(0) - 97]++;
    for (const char of word2) count2[char.charCodeAt(0) - 97]++;

    let distinct1 = count1.filter(c => c > 0).length;
    let distinct2 = count2.filter(c => c > 0).length;

    const totalDistinct = distinct1 + distinct2;

    if (totalDistinct > maxCost + 26) return false;
    if (totalDistinct <= maxCost) return true;

    return (maxCost >= Math.abs(distinct1 - distinct2));
};