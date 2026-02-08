var longestWPI = function(hours) {
    let res = 0;
    let score = 0;
    const seen = {};
    for (let i = 0; i < hours.length; i++) {
        score += hours[i] > 8 ? 1 : -1;
        if (score > 0) {
            res = i + 1;
        } else {
            if (seen[score - 1] !== undefined) {
                res = Math.max(res, i - seen[score - 1]);
            }
            if (seen[score] === undefined) {
                seen[score] = i;
            }
        }
    }
    return res;
};