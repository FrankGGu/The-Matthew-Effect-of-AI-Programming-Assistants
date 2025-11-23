var repeatedSubstringPattern = function(s) {
    const n = s.length;
    if (n < 2) {
        return false;
    }

    const doubledS = s + s;
    const sub = doubledS.substring(1, doubledS.length - 1);

    return sub.includes(s);
};