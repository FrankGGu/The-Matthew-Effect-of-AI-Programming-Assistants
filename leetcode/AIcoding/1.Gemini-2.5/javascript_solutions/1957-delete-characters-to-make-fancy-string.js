var makeFancyString = function(s) {
    if (s.length < 3) {
        return s;
    }

    let result = [s[0], s[1]];

    for (let i = 2; i < s.length; i++) {
        if (s[i] !== result[result.length - 1] || s[i] !== result[result.length - 2]) {
            result.push(s[i]);
        }
    }

    return result.join('');
};