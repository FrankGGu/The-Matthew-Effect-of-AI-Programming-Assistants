function greatestLetter(s) {
    const set = new Set(s);
    let result = '';
    for (let i = 25; i >= 0; i--) {
        const lower = String.fromCharCode(97 + i);
        const upper = String.fromCharCode(65 + i);
        if (set.has(lower) && set.has(upper)) {
            result = upper;
            break;
        }
    }
    return result;
}