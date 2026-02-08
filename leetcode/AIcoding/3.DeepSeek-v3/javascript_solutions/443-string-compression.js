var compress = function(chars) {
    let write = 0;
    let read = 0;
    const n = chars.length;

    while (read < n) {
        const currentChar = chars[read];
        let count = 0;

        while (read < n && chars[read] === currentChar) {
            read++;
            count++;
        }

        chars[write++] = currentChar;

        if (count > 1) {
            const countStr = count.toString();
            for (let i = 0; i < countStr.length; i++) {
                chars[write++] = countStr[i];
            }
        }
    }

    return write;
};