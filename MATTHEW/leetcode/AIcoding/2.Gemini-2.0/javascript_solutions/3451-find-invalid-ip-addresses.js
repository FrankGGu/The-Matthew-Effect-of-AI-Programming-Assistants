var restoreIpAddresses = function(s) {
    const result = [];

    function isValid(str) {
        if (str.length > 1 && str[0] === '0') {
            return false;
        }
        const num = parseInt(str);
        return num >= 0 && num <= 255;
    }

    function backtrack(index, dots, currentIp) {
        if (dots === 4) {
            if (index === s.length) {
                result.push(currentIp.slice(0, -1));
            }
            return;
        }

        for (let i = index; i < Math.min(index + 3, s.length); i++) {
            const segment = s.substring(index, i + 1);
            if (isValid(segment)) {
                backtrack(i + 1, dots + 1, currentIp + segment + '.');
            }
        }
    }

    backtrack(0, 0, '');
    return result;
};