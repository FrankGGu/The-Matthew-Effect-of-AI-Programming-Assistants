var findMirrorScore = function(s) {
    const mirrorMap = {
        '0': '0',
        '1': '1',
        '6': '9',
        '8': '8',
        '9': '6'
    };

    let score = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const char = s[i];
        const mirroredChar = s[n - 1 - i];

        if (mirrorMap[char] !== undefined && mirrorMap[char] === mirroredChar) {
            score++;
        }
    }

    return score;
};