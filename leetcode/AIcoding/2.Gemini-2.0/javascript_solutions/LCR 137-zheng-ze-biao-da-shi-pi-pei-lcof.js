var isSubsequence = function(big, small) {
    let i = 0;
    let j = 0;
    while (i < big.length && j < small.length) {
        if (big[i] === small[j]) {
            j++;
        }
        i++;
    }
    return j === small.length;
};