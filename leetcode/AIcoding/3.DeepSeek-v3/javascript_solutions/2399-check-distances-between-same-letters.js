var checkDistances = function(s, distance) {
    const firstOccurrence = new Array(26).fill(-1);

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 97;
        if (firstOccurrence[charCode] === -1) {
            firstOccurrence[charCode] = i;
        } else {
            const expectedDistance = distance[charCode];
            const actualDistance = i - firstOccurrence[charCode] - 1;
            if (actualDistance !== expectedDistance) {
                return false;
            }
        }
    }

    return true;
};