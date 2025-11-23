var canMakeSubsequence = function(str1, str2) {
    let i = 0;
    let j = 0;

    while (i < str1.length && j < str2.length) {
        if (str1[i] === str2[j] || (str1[i].charCodeAt(0) + 1 === str2[j].charCodeAt(0)) || (str1[i] === 'z' && str2[j] === 'a')) {
            j++;
        }
        i++;
    }

    return j === str2.length;
};