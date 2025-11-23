var ambiguousCoordinates = function(s) {
    function getValidNumbers(numStr) {
        const res = [];

        if (numStr === "0" || numStr[0] !== '0') {
            res.push(numStr);
        }

        for (let i = 1; i < numStr.length; i++) {
            const left = numStr.substring(0, i);
            const right = numStr.substring(i);

            if (left.length > 1 && left[0] === '0') {
                continue;
            }

            if (right[right.length - 1] === '0') {
                continue;
            }

            res.push(left + "." + right);
        }

        return res;
    }

    const digits = s.substring(1, s.length - 1);
    const result = [];

    for (let i = 1; i < digits.length; i++) {
        const xStr = digits.substring(0, i);
        const yStr = digits.substring(i);

        const validX = getValidNumbers(xStr);
        const validY = getValidNumbers(yStr);

        for (const x of validX) {
            for (const y of validY) {
                result.push(`(${x}, ${y})`);
            }
        }
    }

    return result;
};