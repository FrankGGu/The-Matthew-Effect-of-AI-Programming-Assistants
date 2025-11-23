var ambiguousCoordinates = function(s) {
    const result = [];
    const str = s.slice(1, -1);

    for (let i = 1; i < str.length; i++) {
        const left = str.slice(0, i);
        const right = str.slice(i);
        const leftList = generateNumbers(left);
        const rightList = generateNumbers(right);

        for (const l of leftList) {
            for (const r of rightList) {
                result.push(`(${l}, ${r})`);
            }
        }
    }

    return result;
};

function generateNumbers(s) {
    const nums = [];
    if (s.length === 1) {
        nums.push(s);
        return nums;
    }
    if (s[0] !== '0') {
        nums.push(s);
    }
    for (let i = 1; i < s.length; i++) {
        const integer = s.slice(0, i);
        const decimal = s.slice(i);
        if ((integer.length > 1 && integer[0] === '0') || decimal[decimal.length - 1] === '0') {
            continue;
        }
        nums.push(`${integer}.${decimal}`);
    }
    return nums;
}