var checkDistances = function(s, distance) {
    const firstOccurrence = {};
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (firstOccurrence[char] === undefined) {
            firstOccurrence[char] = i;
        }
    }

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        const charCode = char.charCodeAt(0) - 'a'.charCodeAt(0);
        if (firstOccurrence[char] !== i) continue;

        const secondOccurrence = s.indexOf(char, i + 1);
        if (secondOccurrence === -1) return false;

        if (secondOccurrence - i - 1 !== distance[charCode]) {
            return false;
        }
    }

    return true;
};