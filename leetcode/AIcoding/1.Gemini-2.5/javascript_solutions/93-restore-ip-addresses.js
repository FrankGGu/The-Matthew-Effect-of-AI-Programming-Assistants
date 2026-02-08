var restoreIpAddresses = function(s) {
    const result = [];

    function isValid(segment) {
        if (segment.length > 1 && segment[0] === '0') {
            return false;
        }
        const num = parseInt(segment);
        return num >= 0 && num <= 255;
    }

    function backtrack(index, currentParts) {
        const remainingChars = s.length - index;
        const partsNeeded = 4 - currentParts.length;

        if (remainingChars < partsNeeded || remainingChars > partsNeeded * 3) {
            return;
        }

        if (currentParts.length === 4) {
            if (index === s.length) {
                result.push(currentParts.join('.'));
            }
            return;
        }

        for (let i = index; i < Math.min(index + 3, s.length); i++) {
            const segment = s.substring(index, i + 1);
            if (isValid(segment)) {
                currentParts.push(segment);
                backtrack(i + 1, currentParts);
                currentParts.pop();
            }
        }
    }

    backtrack(0, []);
    return result;
};