var spiralOrder = function(R, C, rStart, cStart) {
    const result = [];
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let dir = 0;

    for (let i = 0; i < R * C; i++) {
        if (rStart >= 0 && rStart < R && cStart >= 0 && cStart < C) {
            result.push([rStart, cStart]);
        }
        rStart += directions[dir][0];
        cStart += directions[dir][1];

        if (rStart < 0 || rStart >= R || cStart < 0 || cStart >= C || result.includes([rStart, cStart].toString())) {
            rStart -= directions[dir][0];
            cStart -= directions[dir][1];
            dir = (dir + 1) % 4;
            rStart += directions[dir][0];
            cStart += directions[dir][1];
        }
    }

    return result;
};