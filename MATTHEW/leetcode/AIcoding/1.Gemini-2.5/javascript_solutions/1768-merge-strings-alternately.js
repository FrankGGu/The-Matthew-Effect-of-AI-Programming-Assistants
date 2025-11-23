var mergeAlternately = function(word1, word2) {
    let merged = [];
    let i = 0;
    let j = 0;
    let n1 = word1.length;
    let n2 = word2.length;

    while (i < n1 && j < n2) {
        merged.push(word1[i]);
        merged.push(word2[j]);
        i++;
        j++;
    }

    if (i < n1) {
        merged.push(word1.substring(i));
    }

    if (j < n2) {
        merged.push(word2.substring(j));
    }

    return merged.join('');
};