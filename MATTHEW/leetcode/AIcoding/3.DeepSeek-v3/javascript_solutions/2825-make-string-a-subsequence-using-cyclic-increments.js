var canMakeSubsequence = function(str1, str2) {
    let i = 0, j = 0;
    const n = str1.length, m = str2.length;
    while (i < n && j < m) {
        const c1 = str1[i];
        const c2 = str2[j];
        if (c1 === c2 || nextChar(c1) === c2) {
            j++;
        }
        i++;
    }
    return j === m;
};

function nextChar(c) {
    return c === 'z' ? 'a' : String.fromCharCode(c.charCodeAt(0) + 1);
}