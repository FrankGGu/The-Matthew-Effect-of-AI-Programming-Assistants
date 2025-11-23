function splitString(s, k) {
    const result = [];
    for (let i = 0; i < s.length; i += k) {
        result.push(s.substring(i, i + k));
    }
    return result;
}