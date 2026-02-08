function sortString(s) {
    const count = new Array(26).fill(0);
    for (const c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = '';
    while (result.length < s.length) {
        for (let i = 0; i < 26; i++) {
            if (count[i] > 0) {
                result += String.fromCharCode(i + 'a'.charCodeAt(0));
                count[i]--;
            }
        }
        for (let i = 25; i >= 0; i--) {
            if (count[i] > 0) {
                result += String.fromCharCode(i + 'a'.charCodeAt(0));
                count[i]--;
            }
        }
    }
    return result;
}