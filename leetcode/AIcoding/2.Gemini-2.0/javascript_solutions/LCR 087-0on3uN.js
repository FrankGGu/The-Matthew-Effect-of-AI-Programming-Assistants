var restoreIpAddresses = function(s) {
    const result = [];

    function isValid(segment) {
        if (segment.length > 3 || segment.length === 0 || (segment[0] === '0' && segment.length > 1) || parseInt(segment) > 255) {
            return false;
        }
        return true;
    }

    function backtrack(index, dots, currentIp) {
        if (dots === 4) {
            if (index === s.length) {
                result.push(currentIp.substring(0, currentIp.length - 1));
            }
            return;
        }

        for (let i = index; i < s.length; i++) {
            const segment = s.substring(index, i + 1);
            if (isValid(segment)) {
                backtrack(i + 1, dots + 1, currentIp + segment + '.');
            }
        }
    }

    backtrack(0, 0, '');
    return result;
};