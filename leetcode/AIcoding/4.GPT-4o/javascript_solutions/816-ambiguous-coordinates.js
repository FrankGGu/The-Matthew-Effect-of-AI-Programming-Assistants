var ambiguousCoordinates = function(s) {
    const parse = (s) => {
        const res = [];
        for (let i = 1; i < s.length; i++) {
            const left = s.slice(0, i);
            const right = s.slice(i);
            if (isValid(left) && isValid(right)) {
                res.push(`(${left}, ${right})`);
            }
        }
        return res;
    };

    const isValid = (s) => {
        if (s.length === 0 || (s.length > 1 && s[0] === '0' && s[1] !== '.')) return false;
        if (s.includes('.')) {
            const parts = s.split('.');
            return parts[0].length === 0 || (parts[0].length > 1 && parts[0][0] !== '0') && (parts[1].length === 0 || (parts[1].length > 1 && parts[1][parts[1].length - 1] !== '0'));
        }
        return s.length === 1 || (s[0] !== '0');
    };

    s = s.slice(1, -1);
    const results = parse(s);
    return results;
};