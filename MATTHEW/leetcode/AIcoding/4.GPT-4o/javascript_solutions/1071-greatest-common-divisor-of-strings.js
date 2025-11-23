function gcdOfStrings(str1, str2) {
    function gcd(a, b) {
        if (b === 0) return a;
        return gcd(b, a % b);
    }

    const concat1 = str1 + str2;
    const concat2 = str2 + str1;

    if (concat1 !== concat2) return "";

    const lengthGCD = gcd(str1.length, str2.length);
    return str1.slice(0, lengthGCD);
}