function findLongestWord(dictionary, keyboard) {
    const keySet = new Set(keyboard);
    dictionary.sort((a, b) => a.length - b.length || a.localeCompare(b));
    for (const word of dictionary) {
        let valid = true;
        for (const c of word) {
            if (!keySet.has(c)) {
                valid = false;
                break;
            }
        }
        if (valid) return word;
    }
    return "";
}