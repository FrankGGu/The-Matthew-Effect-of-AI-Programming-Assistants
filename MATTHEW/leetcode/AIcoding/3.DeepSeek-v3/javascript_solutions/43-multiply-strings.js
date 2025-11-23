var multiply = function(num1, num2) {
    if (num1 === "0" || num2 === "0") return "0";

    const m = num1.length, n = num2.length;
    const res = new Array(m + n).fill(0);

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            const product = (num1[i] - '0') * (num2[j] - '0');
            const sum = res[i + j + 1] + product;

            res[i + j + 1] = sum % 10;
            res[i + j] += Math.floor(sum / 10);
        }
    }

    let result = res.join('');
    let start = 0;
    while (start < result.length && result[start] === '0') {
        start++;
    }

    return start === result.length ? "0" : result.substring(start);
};