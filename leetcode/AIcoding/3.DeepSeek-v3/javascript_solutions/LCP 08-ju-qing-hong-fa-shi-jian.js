var getTriggerTime = function(increase, requirements) {
    let n = increase.length;
    let m = requirements.length;
    let res = new Array(m).fill(-1);
    let c = 0, r = 0, h = 0;
    let time = 0;

    for (let i = 0; i < m; i++) {
        if (requirements[i][0] === 0 && requirements[i][1] === 0 && requirements[i][2] === 0) {
            res[i] = 0;
        }
    }

    for (let i = 0; i < n; i++) {
        c += increase[i][0];
        r += increase[i][1];
        h += increase[i][2];
        time++;

        for (let j = 0; j < m; j++) {
            if (res[j] === -1 && c >= requirements[j][0] && r >= requirements[j][1] && h >= requirements[j][2]) {
                res[j] = time;
            }
        }
    }

    return res;
};