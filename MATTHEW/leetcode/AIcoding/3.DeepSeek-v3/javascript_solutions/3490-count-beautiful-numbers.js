var countBeautifulNumbers = function(low, high) {
    let count = 0;
    for (let num = low; num <= high; num++) {
        const str = num.toString();
        const firstDigit = parseInt(str[0]);
        const lastDigit = parseInt(str[str.length - 1]);
        if (gcd(firstDigit, lastDigit) === 1) {
            count++;
        }
    }
    return count;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}