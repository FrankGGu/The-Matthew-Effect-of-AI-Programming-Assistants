var findMinimumOperations = function(s1, s2, s3) {
    let n1 = s1.length, n2 = s2.length, n3 = s3.length;
    let i = 0;
    while (i < Math.min(n1, n2, n3) && s1[i] === s2[i] && s2[i] === s3[i]) {
        i++;
    }
    return n1 + n2 + n3 - 3 * i;
};