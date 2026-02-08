function fractionAddition(expressions) {
    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    function lcm(a, b) {
        return a * b / gcd(a, b);
    }

    let nums = [];
    let i = 0;
    while (i < expressions.length) {
        let sign = 1;
        if (expressions[i] === '-') {
            sign = -1;
            i++;
        } else if (expressions[i] === '+') {
            i++;
        }
        let num = 0;
        while (i < expressions.length && expressions[i] !== '/') {
            num = num * 10 + parseInt(expressions[i]);
            i++;
        }
        i++; // skip '/'
        let den = 0;
        while (i < expressions.length && expressions[i] !== '+' && expressions[i] !== '-') {
            den = den * 10 + parseInt(expressions[i]);
            i++;
        }
        nums.push([sign * num, den]);
    }

    let resultNum = 0;
    let resultDen = 1;

    for (let [num, den] of nums) {
        let commonDen = lcm(resultDen, den);
        let commonNum = resultNum * (commonDen / resultDen) + num * (commonDen / den);
        resultNum = commonNum;
        resultDen = commonDen;
    }

    let g = gcd(resultNum, resultDen);
    resultNum /= g;
    resultDen /= g;

    return `${resultNum}/${resultDen}`;
}