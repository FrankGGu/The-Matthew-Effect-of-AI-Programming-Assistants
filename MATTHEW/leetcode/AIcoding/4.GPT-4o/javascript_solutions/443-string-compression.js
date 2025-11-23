var compress = function(chars) {
    let writeIndex = 0, count = 1;

    for (let i = 1; i <= chars.length; i++) {
        if (i < chars.length && chars[i] === chars[i - 1]) {
            count++;
        } else {
            chars[writeIndex++] = chars[i - 1];
            if (count > 1) {
                const countStr = count.toString();
                for (let j = 0; j < countStr.length; j++) {
                    chars[writeIndex++] = countStr[j];
                }
            }
            count = 1;
        }
    }

    return writeIndex;
};