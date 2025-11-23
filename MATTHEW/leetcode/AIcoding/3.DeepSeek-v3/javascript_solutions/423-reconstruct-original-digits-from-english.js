var originalDigits = function(s) {
    const count = new Array(10).fill(0);
    for (const c of s) {
        if (c === 'z') count[0]++;
        if (c === 'w') count[2]++;
        if (c === 'u') count[4]++;
        if (c === 'x') count[6]++;
        if (c === 'g') count[8]++;
        if (c === 'o') count[1]++; // 1-0-2-4
        if (c === 'h') count[3]++; // 3-8
        if (c === 'f') count[5]++; // 5-4
        if (c === 's') count[7]++; // 7-6
        if (c === 'i') count[9]++; // 9-5-6-8
    }
    count[1] = count[1] - count[0] - count[2] - count[4];
    count[3] = count[3] - count[8];
    count[5] = count[5] - count[4];
    count[7] = count[7] - count[6];
    count[9] = count[9] - count[5] - count[6] - count[8];

    let result = [];
    for (let i = 0; i <= 9; i++) {
        for (let j = 0; j < count[i]; j++) {
            result.push(i.toString());
        }
    }
    return result.join('');
};