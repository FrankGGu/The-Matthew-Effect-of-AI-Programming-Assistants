var canConvert = function(str1, str2) {
    if (str1 === str2) return true;
    const map = new Map();
    const set = new Set();

    for (let i = 0; i < str1.length; i++) {
        const char1 = str1[i];
        const char2 = str2[i];
        if (map.has(char1)) {
            if (map.get(char1) !== char2) {
                return false;
            }
        } else {
            map.set(char1, char2);
            set.add(char2);
        }
    }

    return set.size < 26;
};