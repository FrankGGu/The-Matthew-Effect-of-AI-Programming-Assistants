var numberOfSpecialChars = function(s) {
    const lowerSet = new Set();
    const upperSet = new Set();

    for (const char of s) {
        if (char >= 'a' && char <= 'z') {
            lowerSet.add(char);
        } else if (char >= 'A' && char <= 'Z') {
            upperSet.add(char);
        }
    }

    let specialCount = 0;
    for (let i = 0; i < 26; i++) {
        const lowerChar = String.fromCharCode('a'.charCodeAt(0) + i);
        const upperChar = String.fromCharCode('A'.charCodeAt(0) + i);

        if (lowerSet.has(lowerChar) && upperSet.has(upperChar)) {
            specialCount++;
        }
    }

    return specialCount;
};