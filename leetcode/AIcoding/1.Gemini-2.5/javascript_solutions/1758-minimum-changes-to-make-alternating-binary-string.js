var minChanges = function(s) {
    let changesToMake0101 = 0;
    let changesToMake1010 = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        // For target "0101..."
        // If i is even, expected char is '0'. If i is odd, expected char is '1'.
        if (i % 2 === 0) { // Expected '0'
            if (char === '1') {
                changesToMake0101++;
            }
        } else { // Expected '1'
            if (char === '0') {
                changesToMake0101++;
            }
        }

        // For target "1010..."
        // If i is even, expected char is '1'. If i is odd, expected char is '0'.
        if (i % 2 === 0) { // Expected '1'
            if (char === '0') {
                changesToMake1010++;
            }
        } else { // Expected '0'
            if (char === '1') {
                changesToMake1010++;
            }
        }
    }

    return Math.min(changesToMake0101, changesToMake1010);
};