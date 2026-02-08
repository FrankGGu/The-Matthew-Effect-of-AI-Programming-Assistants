var largestMerge = function(word1, word2) {
    let merge = '';
    while (word1 || word2) {
        if (word1 > word2) {
            merge += word1[0];
            word1 = word1.slice(1);
        } else {
            merge += word2[0];
            word2 = word2.slice(1);
        }
    }
    return merge;
};