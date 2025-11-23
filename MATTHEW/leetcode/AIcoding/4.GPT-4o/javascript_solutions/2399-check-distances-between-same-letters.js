function checkDistances(s, distance) {
    const map = new Map();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (!map.has(char)) {
            map.set(char, i);
        } else {
            const expectedDistance = distance[char.charCodeAt(0) - 'a'.charCodeAt(0)];
            if (i - map.get(char) - 1 !== expectedDistance) {
                return false;
            }
        }
    }

    return true;
}