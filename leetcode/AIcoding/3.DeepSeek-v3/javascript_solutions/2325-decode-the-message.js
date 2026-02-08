var decodeMessage = function(key, message) {
    const uniqueChars = [];
    const seen = new Set();
    for (const char of key) {
        if (char !== ' ' && !seen.has(char)) {
            uniqueChars.push(char);
            seen.add(char);
        }
    }

    const substitution = {};
    for (let i = 0; i < uniqueChars.length; i++) {
        substitution[uniqueChars[i]] = String.fromCharCode('a'.charCodeAt(0) + i);
    }

    let decoded = [];
    for (const char of message) {
        if (char === ' ') {
            decoded.push(' ');
        } else {
            decoded.push(substitution[char]);
        }
    }

    return decoded.join('');
};