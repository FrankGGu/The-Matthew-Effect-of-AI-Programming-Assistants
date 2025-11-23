function gcdOfStrings(word1, word2) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    const len1 = word1.length;
    const len2 = word2.length;
    const gcdLength = gcd(len1, len2);

    const candidate = word1.substring(0, gcdLength);

    function isRepeated(s, t) {
        return s.repeat(t.length / s.length) === t;
    }

    if (isRepeated(candidate, word1) && isRepeated(candidate, word2)) {
        return candidate;
    } else {
        return "";
    }
}