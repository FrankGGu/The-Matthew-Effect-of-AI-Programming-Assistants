var canWrite = function(text, keyboard) {
    const keyboardSet = new Set(keyboard);
    for (let char of text) {
        if (!keyboardSet.has(char)) {
            return false;
        }
    }
    return true;
};