function smallestString(s, a) {
    let n = s.length;
    let arr = Array.from(s);
    let i = 0;

    while (i < n) {
        let start = i;
        while (i < n && arr[i] === 'z') {
            i++;
        }
        let end = i;
        if (end - start > 0) {
            let length = end - start;
            if (length * a >= 26) {
                for (let j = start; j < end; j++) {
                    arr[j] = 'a';
                }
            } else {
                let offset = a % 26;
                for (let j = start; j < end; j++) {
                    arr[j] = String.fromCharCode((arr[j].charCodeAt(0) - 'a'.charCodeAt(0) + offset) % 26 + 'a'.charCodeAt(0));
                }
            }
        }
        i++;
    }

    return arr.join('');
}