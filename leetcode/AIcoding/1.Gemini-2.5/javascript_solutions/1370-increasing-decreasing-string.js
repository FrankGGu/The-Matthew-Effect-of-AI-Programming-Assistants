function sortString(s) {
    const counts = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        counts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let result = [];
    let totalChars = s.length;

    while (totalChars > 0) {
        // Increasing pass
        for (let i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                result.push(String.fromCharCode('a'.charCodeAt(0) + i));
                counts[i]--;
                totalChars--;
            }
        }

        // Decreasing pass
        for (let i = 25; i >= 0; i--) {
            if (counts[i] > 0) {
                result.push(String.fromCharCode('a'.charCodeAt(0) + i));
                counts[i]--;
                totalChars--;
            }
        }
    }

    return result.join('');
}