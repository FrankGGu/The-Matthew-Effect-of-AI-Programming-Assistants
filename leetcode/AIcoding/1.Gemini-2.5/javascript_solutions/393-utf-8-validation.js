var validUtf8 = function(data) {
    let bytesToFollow = 0;

    for (let i = 0; i < data.length; i++) {
        const byte = data[i];

        if (bytesToFollow === 0) {
            if ((byte & 0x80) === 0) {
                bytesToFollow = 0;
            } else if ((byte & 0xE0) === 0xC0) {
                bytesToFollow = 1;
            } else if ((byte & 0xF0) === 0xE0) {
                bytesToFollow = 2;
            } else if ((byte & 0xF8) === 0xF0) {
                bytesToFollow = 3;
            } else {
                return false;
            }
        } else {
            if ((byte & 0xC0) !== 0x80) {
                return false;
            }
            bytesToFollow--;
        }
    }

    return bytesToFollow === 0;
};