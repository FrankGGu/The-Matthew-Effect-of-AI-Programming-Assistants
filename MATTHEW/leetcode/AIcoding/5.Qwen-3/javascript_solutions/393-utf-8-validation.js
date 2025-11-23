function validUtf8(data) {
    let i = 0;
    while (i < data.length) {
        let byte = data[i];
        let mask = 0b10000000;
        let count = 0;
        for (let j = 7; j >= 0; j--) {
            if ((byte & mask) === 0) break;
            count++;
            mask >>>= 1;
        }
        if (count === 1 || count > 4) return false;
        if (count === 0) {
            i++;
            continue;
        }
        for (let j = 1; j < count; j++) {
            if (i + j >= data.length) return false;
            if ((data[i + j] & 0b11000000) !== 0b10000000) return false;
        }
        i += count;
    }
    return true;
}