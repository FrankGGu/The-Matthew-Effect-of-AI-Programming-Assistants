var validUtf8 = function(data) {
    let remainingBytes = 0;

    for (const byte of data) {
        if (remainingBytes === 0) {
            if ((byte >> 7) === 0) {
                continue;
            } else if ((byte >> 5) === 0b110) {
                remainingBytes = 1;
            } else if ((byte >> 4) === 0b1110) {
                remainingBytes = 2;
            } else if ((byte >> 3) === 0b11110) {
                remainingBytes = 3;
            } else {
                return false;
            }
        } else {
            if ((byte >> 6) !== 0b10) {
                return false;
            }
            remainingBytes--;
        }
    }

    return remainingBytes === 0;
};