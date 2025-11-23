var executeInstructions = function(n, startPos, s) {
    const m = s.length;
    const result = [];

    for (let i = 0; i < m; i++) {
        let x = startPos[0];
        let y = startPos[1];
        let count = 0;

        for (let j = i; j < m; j++) {
            if (s[j] === 'R') {
                y++;
            } else if (s[j] === 'L') {
                y--;
            } else if (s[j] === 'U') {
                x--;
            } else {
                x++;
            }

            if (x < 0 || x >= n || y < 0 || y >= n) {
                break;
            }
            count++;
        }
        result.push(count);
    }

    return result;
};