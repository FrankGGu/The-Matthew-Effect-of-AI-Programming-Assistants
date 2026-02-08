var decodeMessage = function(key, message) {
    const map = new Map();
    let currChar = 'a';

    for (const char of key) {
        if (char !== ' ' && !map.has(char)) {
            map.set(char, currChar);
            currChar = String.fromCharCode(currChar.charCodeAt(0) + 1);
        }
    }

    let decodedMessage = '';
    for (const char of message) {
        decodedMessage += char === ' ' ? ' ' : map.get(char);
    }

    return decodedMessage;
};