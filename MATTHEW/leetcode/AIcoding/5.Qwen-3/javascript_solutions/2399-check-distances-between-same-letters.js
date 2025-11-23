function checkDistances(s, distance) {
    const map = {};
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (map[char] !== undefined) {
            const prevIndex = map[char];
            const expectedDistance = distance[char.charCodeAt(0) - 'a'.charCodeAt(0)];
            if (i - prevIndex - 1 !== expectedDistance) {
                return false;
            }
        } else {
            map[char] = i;
        }
    }
    return true;
}