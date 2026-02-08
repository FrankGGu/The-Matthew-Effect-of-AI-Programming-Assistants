var executeInstructions = function(n, startPos, s) {
    const directions = { 'R': [0, 1], 'L': [0, -1], 'U': [-1, 0], 'D': [1, 0] };
    const result = new Array(s.length).fill(0);

    for (let i = 0; i < s.length; i++) {
        let x = startPos[0], y = startPos[1], count = 0;
        for (let j = i; j < s.length; j++) {
            const dir = s[j];
            x += directions[dir][0];
            y += directions[dir][1];
            if (x >= 0 && x < n && y >= 0 && y < n) {
                count++;
            } else {
                break;
            }
        }
        result[i] = count;
    }

    return result;
};