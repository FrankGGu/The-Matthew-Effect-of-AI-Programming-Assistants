function multiply(num1, num2) {
    if (num1 === "0" || num2 === "0") return "0";

    const len1 = num1.length;
    const len2 = num2.length;
    const result = new Array(len1 + len2).fill(0);

    for (let i = len1 - 1; i >= 0; i--) {
        for (let j = len2 - 1; j >= 0; j--) {
            const digit1 = parseInt(num1[i]);
            const digit2 = parseInt(num2[j]);
            const product = digit1 * digit2;
            const pos1 = i + j;
            const pos2 = i + j + 1;

            result[pos2] += product % 10;
            result[pos1] += Math.floor(product / 10);
        }
    }

    let carry = 0;
    for (let i = result.length - 1; i >= 0; i--) {
        const sum = result[i] + carry;
        result[i] = sum % 10;
        carry = Math.floor(sum / 10);
    }

    let start = 0;
    while (start < result.length && result[start] === 0) {
        start++;
    }

    return result.slice(start).join('');
}