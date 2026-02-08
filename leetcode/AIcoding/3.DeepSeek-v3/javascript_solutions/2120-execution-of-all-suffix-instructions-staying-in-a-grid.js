var executeInstructions = function(n, startPos, s) {
    const result = [];
    for (let i = 0; i < s.length; i++) {
        let x = startPos[0];
        let y = startPos[1];
        let count = 0;
        for (let j = i; j < s.length; j++) {
            const move = s[j];
            if (move === 'L') y--;
            else if (move === 'R') y++;
            else if (move === 'U') x--;
            else if (move === 'D') x++;
            if (x < 0 || x >= n || y < 0 || y >= n) break;
            count++;
        }
        result.push(count);
    }
    return result;
};