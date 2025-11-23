var gcdOfStrings = function(str1, str2) {
    if (str1 + str2 !== str2 + str1) {
        return "";
    }

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    const len1 = str1.length;
    const len2 = str2.length;
    const commonDivisorLength = gcd(len1, len2);

    return str1.substring(0, commonDivisorLength);
};