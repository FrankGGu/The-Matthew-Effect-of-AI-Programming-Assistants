var largestMerge = function(word1, word2) {
    let merge = [];
    let i = 0, j = 0;
    while (i < word1.length && j < word2.length) {
        if (word1.slice(i) > word2.slice(j)) {
            merge.push(word1[i++]);
        } else {
            merge.push(word2[j++]);
        }
    }
    while (i < word1.length) {
        merge.push(word1[i++]);
    }
    while (j < word2.length) {
        merge.push(word2[j++]);
    }
    return merge.join('');
};