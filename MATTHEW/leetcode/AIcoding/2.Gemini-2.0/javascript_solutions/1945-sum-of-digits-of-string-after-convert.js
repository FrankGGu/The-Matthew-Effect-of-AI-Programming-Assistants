var getLucky = function(s, k) {
    let converted = "";
    for (let char of s) {
        converted += (char.charCodeAt(0) - 'a'.charCodeAt(0) + 1).toString();
    }

    let sum = 0;
    for (let i = 0; i < k; i++) {
        sum = 0;
        for (let char of converted) {
            sum += parseInt(char);
        }
        converted = sum.toString();
    }

    return sum;
};