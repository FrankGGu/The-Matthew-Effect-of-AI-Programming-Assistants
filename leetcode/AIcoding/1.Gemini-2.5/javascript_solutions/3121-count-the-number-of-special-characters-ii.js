function countSpecialCharacters(s) {
    let specialCount = 0;

    for (let i = 0; i < 26; i++) {
        const lowerChar = String.fromCharCode('a'.charCodeAt(0) + i);
        const upperChar = String.fromCharCode('A'.charCodeAt(0) + i);

        let lastLowerIndex = -1;
        let firstUpperIndex = -1;

        for (let j = 0; j < s.length; j++) {
            if (s[j] === lowerChar) {
                lastLowerIndex = j;
            }
            if (s[j] === upperChar) {
                if (firstUpperIndex === -1) {
                    firstUpperIndex = j;
                }
            }
        }

        if (lastLowerIndex !== -1 && firstUpperIndex !== -1 && lastLowerIndex < firstUpperIndex) {
            specialCount++;
        }
    }

    return specialCount;
}