var findTheOriginalTypedString = function(typed) {
    if (!typed || typed.length === 0) {
        return "";
    }

    let result = [];
    for (let i = 0; i < typed.length; i++) {
        if (result.length === 0 || typed[i] !== result[result.length - 1]) {
            result.push(typed[i]);
        }
    }

    return result.join("");
};