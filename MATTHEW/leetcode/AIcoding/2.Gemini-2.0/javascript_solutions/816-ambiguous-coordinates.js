var ambiguousCoordinates = function(s) {
    s = s.substring(1, s.length - 1);
    const n = s.length;
    const ans = [];

    function possible(str) {
        const res = [];
        if (str.length === 1 || str[0] !== '0') {
            res.push(str);
        }
        if (str.length > 1 && str[0] !== '0' && str[str.length - 1] !== '0') {
            res.push(str[0] + '.' + str.substring(1));
        }
        if (str[0] === '0' && str.length > 1 && str[str.length - 1] !== '0') {
            res.push('0.' + str.substring(1));
        }

        return res;
    }

    for (let i = 1; i < n; i++) {
        const left = s.substring(0, i);
        const right = s.substring(i);

        const leftPossibilities = possible(left);
        const rightPossibilities = possible(right);

        for (const l of leftPossibilities) {
            for (const r of rightPossibilities) {
                ans.push('(' + l + ', ' + r + ')');
            }
        }
    }

    return ans;
};