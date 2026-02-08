function minLength(s) {
    const count = new Array(26).fill(0);
    for (const char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let length = 0;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            length += Math.ceil(count[i] / 2) * 2;
        }
    }

    return length === 0 ? 0 : length - (length % 2 === 0 ? 2 : 1);
}