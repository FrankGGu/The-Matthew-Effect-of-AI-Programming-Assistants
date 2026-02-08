var restoreIpAddresses = function(s) {
    const result = [];

    function isValid(sPart) {
        if (sPart.length === 0 || sPart.length > 3) {
            return false;
        }
        if (sPart.length > 1 && sPart[0] === '0') {
            return false;
        }
        const num = parseInt(sPart);
        return num >= 0 && num <= 255;
    }

    function backtrack(start, currentParts) {
        if (currentParts.length === 4) {
            if (start === s.length) {
                result.push(currentParts.join('.'));
            }
            return;
        }

        const remainingParts = 4 - currentParts.length;
        const remainingLength = s.length - start;
        if (remainingLength < remainingParts || remainingLength > remainingParts * 3) {
            return;
        }

        for (let i = start; i < Math.min(start + 3, s.length); i++) {
            const segment = s.substring(start, i + 1);
            if (isValid(segment)) {
                currentParts.push(segment);
                backtrack(i + 1, currentParts);
                currentParts.pop();
            } else {
                break;
            }
        }
    }

    backtrack(0, []);
    return result;
};