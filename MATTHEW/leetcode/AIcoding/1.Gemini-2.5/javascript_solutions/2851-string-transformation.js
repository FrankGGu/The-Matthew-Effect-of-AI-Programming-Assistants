var canConvert = function(str1, str2) {
    if (str1 === str2) {
        return true;
    }

    const mapping = new Map();
    const targetChars = new Set();

    for (let i = 0; i < str1.length; i++) {
        const char1 = str1[i];
        const char2 = str2[i];

        if (mapping.has(char1)) {
            if (mapping.get(char1) !== char2) {
                return false;
            }
        } else {
            mapping.set(char1, char2);
        }
        targetChars.add(char2);
    }

    return targetChars.size < 26;
};