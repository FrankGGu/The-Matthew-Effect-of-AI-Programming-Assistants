function hashDividedString(s, k) {
    const n = s.length;
    const result = [];

    for (let i = 0; i < n; i += k) {
        const segment = s.substring(i, i + k);
        const hashValue = Array.from(segment).reduce((sum, char) => sum + char.charCodeAt(0), 0);
        result.push(hashValue);
    }

    return result;
}