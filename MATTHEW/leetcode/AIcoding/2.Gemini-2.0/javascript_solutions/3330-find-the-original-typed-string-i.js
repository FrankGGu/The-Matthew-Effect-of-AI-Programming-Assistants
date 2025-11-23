var isLongPressedName = function(typed, name) {
    let i = 0;
    let j = 0;

    while (i < typed.length && j < name.length) {
        if (typed[i] === name[j]) {
            i++;
            j++;
        } else if (i > 0 && typed[i] === typed[i - 1]) {
            i++;
        } else {
            return false;
        }
    }

    while (i < typed.length && typed[i] === typed[i - 1]) {
        i++;
    }

    return i === typed.length && j === name.length;
};