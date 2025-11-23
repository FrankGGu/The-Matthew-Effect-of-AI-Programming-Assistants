var restoreIpAddresses = function(s) {
    const result = [];

    const backtrack = (start, path) => {
        if (path.length === 4 && start === s.length) {
            result.push(path.join('.'));
            return;
        }
        if (path.length >= 4) return;

        for (let len = 1; len <= 3; len++) {
            const segment = s.substring(start, start + len);
            if (segment.length > 0 && segment.length <= 3 && 
                (segment[0] !== '0' || segment.length === 1) && 
                (parseInt(segment) <= 255)) {
                path.push(segment);
                backtrack(start + len, path);
                path.pop();
            }
        }
    };

    backtrack(0, []);
    return result;
};