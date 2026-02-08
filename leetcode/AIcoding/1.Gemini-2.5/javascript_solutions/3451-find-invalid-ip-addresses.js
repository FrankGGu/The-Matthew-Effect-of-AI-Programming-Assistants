var restoreIpAddresses = function(s) {
    const result = [];
    const path = [];

    if (s.length < 4 || s.length > 12) {
        return result;
    }

    function isValidSegment(segment) {
        if (segment.length === 0 || segment.length > 3) {
            return false;
        }
        if (segment.length > 1 && segment[0] === '0') {
            return false;
        }
        const num = parseInt(segment, 10);
        return num >= 0 && num <= 255;
    }

    function backtrack(startIndex, segmentCount) {
        if (segmentCount === 4) {
            if (startIndex === s.length) {
                result.push(path.join('.'));
            }
            return;
        }

        if (startIndex === s.length) {
            return;
        }

        for (let length = 1; length <= 3; length++) {
            const endIndex = startIndex + length;

            if (endIndex > s.length) {
                break;
            }

            const segment = s.substring(startIndex, endIndex);

            if (isValidSegment(segment)) {
                path.push(segment);
                backtrack(endIndex, segmentCount + 1);
                path.pop();
            } else {
                if (segment[0] === '0') {
                    break;
                }
            }
        }
    }

    backtrack(0, 0);
    return result;
};