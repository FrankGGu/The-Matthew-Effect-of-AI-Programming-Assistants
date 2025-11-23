var longestHappyString = function(a, b, c) {
    const res = [];
    const chars = [
        [a, 'a'],
        [b, 'b'],
        [c, 'c']
    ];

    while (true) {
        // Sort characters by their remaining counts in descending order
        chars.sort((x, y) => y[0] - x[0]);

        let char1 = chars[0];
        let char2 = chars[1]; // This might be for a character with count 0 or undefined if only one type remains

        let canAppendChar1 = true;
        // Check if appending char1 would create 'aaa', 'bbb', or 'ccc'
        if (res.length >= 2 && res[res.length - 1] === char1[1] && res[res.length - 2] === char1[1]) {
            canAppendChar1 = false;
        }

        if (canAppendChar1 && char1[0] > 0) {
            // Append char1 once
            res.push(char1[1]);
            char1[0]--;

            // Try to append char1 a second time
            // Check if there are still char1s left AND it won't create 'aaa', 'bbb', 'ccc'
            if (char1[0] > 0 && (res.length < 2 || res[res.length - 1] !== char1[1] || res[res.length - 2] !== char1[1])) {
                // Append char1 twice if it's still more or equally abundant than char2
                // or if char2 is exhausted (char2[0] would be 0 or char2 itself undefined)
                if (!char2 || char1[0] >= char2[0]) {
                    res.push(char1[1]);
                    char1[0]--;
                }
            }
        } else if (char2 && char2[0] > 0) { // Cannot append char1, try to append char2
            res.push(char2[1]);
            char2[0]--;
        } else { // No valid move possible with char1 or char2
            break;
        }
    }

    return res.join('');
};