var reorganizeString = function(s) {
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const pq = [];
    for (let i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            pq.push([freq[i], String.fromCharCode(i + 'a'.charCodeAt(0))]);
        }
    }

    pq.sort((a, b) => b[0] - a[0]);

    let result = "";
    while (pq.length > 0) {
        const [freq1, char1] = pq.shift();
        if (result.length > 0 && result[result.length - 1] === char1) {
            if (pq.length === 0) return "";
            const [freq2, char2] = pq.shift();
            result += char2;
            pq.unshift([freq2 - 1, char2]);
            pq.unshift([freq1, char1]);
            pq.sort((a, b) => b[0] - a[0]);
        } else {
            result += char1;
            if (freq1 - 1 > 0) {
                pq.unshift([freq1 - 1, char1]);
                pq.sort((a, b) => b[0] - a[0]);
            }
        }
    }

    return result;
};