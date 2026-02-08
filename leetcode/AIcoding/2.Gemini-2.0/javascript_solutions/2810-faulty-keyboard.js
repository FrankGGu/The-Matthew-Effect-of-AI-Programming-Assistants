var finalString = function(s) {
    let result = "";
    for (let char of s) {
        if (char === 'i') {
            result = result.split("").reverse().join("");
        } else {
            result += char;
        }
    }
    return result;
};