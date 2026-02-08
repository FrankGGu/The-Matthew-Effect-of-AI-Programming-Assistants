var partitionString = function(s, k) {
    let count = 1;
    let currentSubstr = "";
    for (let i = 0; i < s.length; i++) {
        let num = parseInt(s[i]);
        if (num > k) return -1;

        if (parseInt(currentSubstr + s[i]) <= k) {
            currentSubstr += s[i];
        } else {
            count++;
            currentSubstr = s[i];
        }
    }
    return count;
};