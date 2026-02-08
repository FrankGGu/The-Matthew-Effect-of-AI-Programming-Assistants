var makeFancyString = function(s) {
    let result = "";
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (result.length > 0 && s[i] === result[result.length - 1]) {
            count++;
        } else {
            count = 1;
        }

        if (count <= 2) {
            result += s[i];
        }
    }
    return result;
};