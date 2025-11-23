function divideString(s, k, fill) {
    const result = [];
    for (let i = 0; i < s.length; i += k) {
        const group = s.slice(i, i + k);
        result.push(group.padEnd(k, fill));
    }
    return result;
}