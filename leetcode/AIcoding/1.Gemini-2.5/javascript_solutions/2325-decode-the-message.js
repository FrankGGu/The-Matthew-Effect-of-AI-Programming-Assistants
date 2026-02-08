var decodeMessage = function(key, message) {
    const decodeMap = new Map();
    let charCode = 'a'.charCodeAt(0);

    for (let i = 0; i < key.length; i++) {
        const char = key[i];
        if (char !== ' ' && !decodeMap.has(char)) {
            decodeMap.set(char, String.fromCharCode(charCode));
            charCode++;
            if (charCode > 'z'.charCodeAt(0)) {
                break;
            }
        }
    }

    let decodedMessage = [];
    for (let i = 0; i < message.length; i++) {
        const char = message[i];
        if (char === ' ') {
            decodedMessage.push(' ');
        } else {
            decodedMessage.push(decodeMap.get(char));
        }
    }

    return decodedMessage.join('');
};