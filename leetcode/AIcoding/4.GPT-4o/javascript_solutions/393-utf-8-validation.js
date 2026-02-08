var validUtf8 = function(data) {
    let bytesRemaining = 0;

    for (let num of data) {
        if (bytesRemaining === 0) {
            if ((num >> 5) === 0b110) bytesRemaining = 1;
            else if ((num >> 4) === 0b1110) bytesRemaining = 2;
            else if ((num >> 3) === 0b11110) bytesRemaining = 3;
            else if ((num >> 7) !== 0) return false;
        } else {
            if ((num >> 6) !== 0b10) return false;
            bytesRemaining--;
        }
    }

    return bytesRemaining === 0;
};