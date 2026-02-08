var multiply = function(num1, num2) {
    if (num1 === "0" || num2 === "0") return "0";

    const m = num1.length;
    const n = num2.length;
    const product = new Array(m + n).fill(0);

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            const digit1 = parseInt(num1[i]);
            const digit2 = parseInt(num2[j]);
            const pos1 = i + j;
            const pos2 = i + j + 1;
            const sum = digit1 * digit2 + product[pos2];

            product[pos2] = sum % 10;
            product[pos1] += Math.floor(sum / 10);
        }
    }

    let result = "";
    for (const digit of product) {
        if (!(result.length === 0 && digit === 0)) {
            result += digit;
        }
    }

    return result === "" ? "0" : result;
};