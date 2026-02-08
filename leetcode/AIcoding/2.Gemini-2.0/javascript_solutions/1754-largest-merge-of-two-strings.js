var largestMerge = function(word1, word2) {
    let i = 0;
    let j = 0;
    let result = "";

    while (i < word1.length || j < word2.length) {
        if (word1.substring(i) > word2.substring(j)) {
            result += word1[i];
            i++;
        } else {
            result += word2[j];
            j++;
        }
    }

    return result;
};