var checkString = function(s1, s2) {
    if (s2.length < s1.length) return false;

    for (let i = 0; i <= s2.length - s1.length; i++) {
        if (s2.substring(i, i + s1.length) === s1) return true;
    }

    return false;
};

var solve = function(s1, s2) {
    const reversedS1 = s1.split("").reverse().join("");
    return checkString(s1, s2) || checkString(reversedS1, s2);
};