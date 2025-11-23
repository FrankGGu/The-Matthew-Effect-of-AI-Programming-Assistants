var makeFancyString = function(s) {
    let result = '';
    let count = 1;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === s[i + 1]) {
            count++;
        } else {
            count = 1;
        }

        if (count < 3) {
            result += s[i];
        }
    }

    return result;
};