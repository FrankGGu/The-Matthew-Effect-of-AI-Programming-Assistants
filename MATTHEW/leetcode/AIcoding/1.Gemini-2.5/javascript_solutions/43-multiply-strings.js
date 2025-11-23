var multiply = function(num1, num2) {
    if (num1 === "0" || num2 === "0") {
        return "0";
    }

    const m = num1.length;
    const n = num2.length;
    const res = new Array(m + n).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        const digit2 = parseInt(num2[i]);
        for (let j = m - 1; j >= 0; j--) {
            const digit1 = parseInt(num1[j]);

            const product = digit1 * digit2;

            // The product of digits at num1[j] and num2[i] contributes to positions i+j and i+j+1
            // in the result array (from left to right, 0-indexed).
            // pos2 is the current digit's position (units place of the product).
            // pos1 is the carry's position (tens place of the product).
            const pos1 = i + j;
            const pos2 = i + j + 1;

            const sum = product + res[pos2];

            res[pos2] = sum % 10;
            res[pos1] += Math.floor(sum / 10);
        }
    }

    let i = 0;
    while (i < res.length - 1 && res[i] === 0) {
        i++;
    }

    return res.slice(i).join("");
};