function largestMultipleOfThree(digits) {
    digits.sort((a, b) => b - a);
    let sum = digits.reduce((a, b) => a + b, 0);
    if (sum % 3 === 0) return digits.join('');

    const remainders = [[], [], []];
    for (const num of digits) {
        remainders[num % 3].push(num);
    }

    if (sum % 3 === 1) {
        if (remainders[1].length > 0) {
            remainders[1].sort((a, b) => a - b);
            remainders[1].pop();
        } else if (remainders[2].length > 1) {
            remainders[2].sort((a, b) => a - b);
            remainders[2].pop();
            remainders[2].pop();
        } else {
            return '';
        }
    } else if (sum % 3 === 2) {
        if (remainders[2].length > 0) {
            remainders[2].sort((a, b) => a - b);
            remainders[2].pop();
        } else if (remainders[1].length > 1) {
            remainders[1].sort((a, b) => a - b);
            remainders[1].pop();
            remainders[1].pop();
        } else {
            return '';
        }
    }

    const result = [...remainders[0], ...remainders[1], ...remainders[2]].sort((a, b) => b - a);
    if (result[0] === 0) return '0';
    return result.join('');
}