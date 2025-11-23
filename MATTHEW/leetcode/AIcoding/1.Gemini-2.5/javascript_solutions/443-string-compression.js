var compress = function(chars) {
    let write = 0;
    let read = 0;
    const n = chars.length;

    while (read < n) {
        let currentChar = chars[read];
        let count = 0;
        while (read < n && chars[read] === currentChar) {
            read++;
            count++;
        }

        chars[write] = currentChar;
        write++;

        if (count > 1) {
            let countStr = count.toString();
            for (let i = 0; i < countStr.length; i++) {
                chars[write] = countStr[i];
                write++;
            }
        }
    }

    return write;
};