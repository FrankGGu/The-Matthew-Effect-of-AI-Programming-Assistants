var maximumOddBinaryNumber = function(s) {
    let ones = 0;
    for (let char of s) {
        if (char === '1') {
            ones++;
        }
    }

    let result = "";
    for (let i = 0; i < ones - 1; i++) {
        result += "1";
    }

    for (let i = 0; i < s.length - ones; i++) {
        result += "0";
    }

    result += "1";

    return result;
};