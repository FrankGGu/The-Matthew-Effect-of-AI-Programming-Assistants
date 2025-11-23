var canDivideString = function(s, k) {
    let count = 1;
    for (let i = 1; i < s.length; i++) {
        if (s[i] !== s[i - 1]) {
            count++;
        }
    }
    return count <= k;
};