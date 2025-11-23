var restoreIpAddresses = function(s) {
    const result = [];

    const backtrack = (start, path) => {
        if (path.length === 4 && start === s.length) {
            result.push(path.join('.'));
            return;
        }
        if (path.length === 4 || start === s.length) {
            return;
        }

        for (let len = 1; len <= 3; len++) {
            if (start + len > s.length) break;
            const segment = s.substring(start, start + len);
            if ((segment.length > 1 && segment[0] === '0') || parseInt(segment) > 255) {
                continue;
            }
            path.push(segment);
            backtrack(start + len, path);
            path.pop();
        }
    };

    backtrack(0, []);
    return result;
};