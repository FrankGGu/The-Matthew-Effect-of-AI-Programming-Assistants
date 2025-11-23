var fractionAddition = function(expression) {
    const gcd = (a, b) => {
        return b === 0 ? Math.abs(a) : gcd(b, a % b);
    };

    let totalNumerator = 0;
    let totalDenominator = 1;

    let i = 0;
    const n = expression.length;

    while (i < n) {
        let sign = 1;
        if (expression[i] === '-') {
            sign = -1;
            i++;
        } else if (expression[i] === '+') {
            i++;
        }

        let currentNumerator = 0;
        while (i < n && expression[i] >= '0' && expression[i] <= '9') {
            currentNumerator = currentNumerator * 10 + parseInt(expression[i]);
            i++;
        }
        currentNumerator *= sign;

        i++; // Skip '/'

        let currentDenominator = 0;
        while (i < n && expression[i] >= '0' && expression[i] <= '9') {
            currentDenominator = currentDenominator * 10 + parseInt(expression[i]);
            i++;
        }

        totalNumerator = totalNumerator * currentDenominator + currentNumerator * totalDenominator;
        totalDenominator = totalDenominator * currentDenominator;

        const commonDivisor = gcd(totalNumerator, totalDenominator);
        totalNumerator /= commonDivisor;
        totalDenominator /= commonDivisor;
    }

    return totalNumerator + "/" + totalDenominator;
};