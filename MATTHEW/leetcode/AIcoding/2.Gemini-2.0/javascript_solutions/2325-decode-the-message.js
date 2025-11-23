var decodeMessage = function(key, message) {
    let map = new Map();
    let charCode = 'a'.charCodeAt(0);
    let decoded = "";
    let currentLetter = 'a';

    for (let i = 0; i < key.length; i++) {
        if (key[i] !== ' ' && !map.has(key[i])) {
            map.set(key[i], currentLetter);
            currentLetter = String.fromCharCode(currentLetter.charCodeAt(0) + 1);
        }
    }

    for (let i = 0; i < message.length; i++) {
        if (message[i] === ' ') {
            decoded += ' ';
        } else {
            decoded += map.get(message[i]);
        }
    }

    return decoded;
};