var sortString = function(s) {
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let result = "";
    while (result.length < s.length) {
        for (let i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                result += String.fromCharCode(i + 'a'.charCodeAt(0));
                counts[i]--;
            }
        }
        for (let i = 25; i >= 0; i--) {
            if (counts[i] > 0) {
                result += String.fromCharCode(i + 'a'.charCodeAt(0));
                counts[i]--;
            }
        }
    }

    return result;
};