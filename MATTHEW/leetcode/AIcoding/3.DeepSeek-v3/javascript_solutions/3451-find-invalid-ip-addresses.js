var restoreIpAddresses = function(s) {
    const result = [];

    const backtrack = (start, parts, current) => {
        if (parts === 4) {
            if (start === s.length) {
                result.push(current.join('.'));
            }
            return;
        }

        for (let len = 1; len <= 3; len++) {
            if (start + len > s.length) break;
            const segment = s.substring(start, start + len);
            if ((segment.length > 1 && segment[0] === '0') || parseInt(segment) > 255) {
                continue;
            }
            current.push(segment);
            backtrack(start + len, parts + 1, current);
            current.pop();
        }
    };

    backtrack(0, 0, []);
    return result;
};