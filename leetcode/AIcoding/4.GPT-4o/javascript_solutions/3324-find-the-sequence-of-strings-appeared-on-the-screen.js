function findTheString(strings) {
    const seen = new Set();
    for (let s of strings) {
        seen.add(s);
    }
    let result = [];
    for (let s of strings) {
        if (!seen.has(s.split('').reverse().join(''))) {
            result.push(s);
        }
    }
    return result;
}