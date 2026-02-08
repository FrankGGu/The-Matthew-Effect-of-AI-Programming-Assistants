var makeFancyString = function(s) {
    let result = [];
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (i > 0 && s[i] === s[i - 1]) {
            count++;
        } else {
            count = 1;
        }
        if (count < 3) {
            result.push(s[i]);
        }
    }
    return result.join('');
};