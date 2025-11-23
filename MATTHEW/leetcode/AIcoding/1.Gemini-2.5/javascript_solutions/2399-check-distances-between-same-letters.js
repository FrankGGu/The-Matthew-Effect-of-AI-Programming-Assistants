var checkDistances = function(s, distance) {
    const firstOccurrences = new Array(26).fill(-1);

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);

        if (firstOccurrences[charCode] === -1) {
            firstOccurrences[charCode] = i;
        } else {
            const firstIdx = firstOccurrences[charCode];
            const actualDistance = i - firstIdx - 1;

            if (actualDistance !== distance[charCode]) {
                return false;
            }
        }
    }

    return true;
};