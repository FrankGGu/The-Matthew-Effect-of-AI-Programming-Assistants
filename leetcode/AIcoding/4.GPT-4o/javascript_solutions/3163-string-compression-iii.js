var compress = function(chars) {
    let writeIndex = 0, readIndex = 0;
    while (readIndex < chars.length) {
        let char = chars[readIndex];
        let count = 0;

        while (readIndex < chars.length && chars[readIndex] === char) {
            readIndex++;
            count++;
        }

        chars[writeIndex++] = char;
        if (count > 1) {
            let countStr = count.toString();
            for (let c of countStr) {
                chars[writeIndex++] = c;
            }
        }
    }

    return writeIndex;
};