var minChanges = function(s) {
    let changes = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const char = s[i];
        const remainder = i % 3;

        if (remainder === 0) {
            if (char !== '0') {
                changes++;
            }
        } else if (remainder === 1) {
            if (char !== '1') {
                changes++;
            }
        } else { // remainder === 2
            if (char !== '0') {
                changes++;
            }
        }
    }

    return changes;
};