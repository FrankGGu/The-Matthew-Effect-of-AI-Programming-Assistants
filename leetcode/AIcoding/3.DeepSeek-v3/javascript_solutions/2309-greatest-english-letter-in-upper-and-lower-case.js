var greatestLetter = function(s) {
    const lowerSet = new Set();
    const upperSet = new Set();
    let maxChar = '';

    for (const char of s) {
        if (char >= 'a' && char <= 'z') {
            lowerSet.add(char);
        } else if (char >= 'A' && char <= 'Z') {
            upperSet.add(char);
        }
    }

    for (const char of lowerSet) {
        const upperChar = char.toUpperCase();
        if (upperSet.has(upperChar)) {
            if (maxChar === '' || upperChar > maxChar) {
                maxChar = upperChar;
            }
        }
    }

    return maxChar;
};