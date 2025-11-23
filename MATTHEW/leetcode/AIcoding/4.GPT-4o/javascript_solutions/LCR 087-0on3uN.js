var restoreIpAddresses = function(s) {
    const result = [];

    const backtrack = (start, path) => {
        if (path.length === 4 && start === s.length) {
            result.push(path.join('.'));
            return;
        }
        if (path.length >= 4) return;

        for (let len = 1; len <= 3; len++) {
            const segment = s.slice(start, start + len);
            if (segment.length > 1 && segment[0] === '0' || +segment > 255) continue;
            backtrack(start + len, [...path, segment]);
        }
    };

    backtrack(0, []);
    return result;
};