var maximum69Number  = function(num) {
    const s = num.toString();
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '6') {
            return parseInt(s.substring(0, i) + '9' + s.substring(i + 1));
        }
    }
    return num;
};