var getLucky = function(s, k) {
    let numStr = '';
    for (let char of s) {
        numStr += (char.charCodeAt(0) - 'a'.charCodeAt(0) + 1).toString();
    }

    for (let i = 0; i < k; i++) {
        let sum = 0;
        for (let digit of numStr) {
            sum += parseInt(digit, 10);
        }
        numStr = sum.toString();
    }

    return parseInt(numStr, 10);
};