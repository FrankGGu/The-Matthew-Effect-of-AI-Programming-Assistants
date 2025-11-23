function largestGoodInteger(s) {
    let max = -1;
    for (let i = 0; i < s.length - 2; i++) {
        if (s[i] === s[i+1] && s[i] === s[i+2]) {
            const num = parseInt(s.substring(i, i+3));
            if (num > max) {
                max = num;
            }
        }
    }
    return max === -1 ? "" : max.toString();
}