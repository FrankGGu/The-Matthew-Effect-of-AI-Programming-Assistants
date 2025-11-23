var compress = function(chars) {
    let index = 0;
    let count = 1;
    let writeIndex = 0;

    for (let i = 0; i < chars.length; i++) {
        if (i + 1 < chars.length && chars[i] === chars[i + 1]) {
            count++;
        } else {
            chars[writeIndex++] = chars[i];
            if (count > 1) {
                let countStr = count.toString();
                for (let j = 0; j < countStr.length; j++) {
                    chars[writeIndex++] = countStr[j];
                }
            }
            count = 1;
        }
    }

    return writeIndex;
};