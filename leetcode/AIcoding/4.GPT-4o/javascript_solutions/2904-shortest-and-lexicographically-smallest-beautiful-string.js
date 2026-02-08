function smallestBeautifulString(s, k) {
    const n = s.length;
    const result = Array.from(s);
    const alphabet = Array.from({ length: k }, (_, i) => String.fromCharCode('a'.charCodeAt(0) + i));

    const isValid = (str) => {
        for (let i = 0; i < str.length - 2; i++) {
            if (str[i] === str[i + 1] && str[i] === str[i + 2]) return false;
            if (str[i] === str[i + 1]) return false;
        }
        return true;
    };

    const nextSmallest = (str) => {
        for (let i = n - 1; i >= 0; i--) {
            const index = alphabet.indexOf(str[i]);
            if (index < k - 1) {
                str[i] = alphabet[index + 1];
                for (let j = i + 1; j < n; j++) {
                    str[j] = alphabet[0];
                }
                return str;
            }
        }
        return null;
    };

    while (true) {
        const next = nextSmallest(result);
        if (!next) return "";
        if (isValid(next.join(''))) return next.join('');
        result.splice(0, n, ...next);
    }
}