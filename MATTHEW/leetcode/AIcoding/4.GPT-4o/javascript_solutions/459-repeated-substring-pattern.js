var repeatedSubstringPattern = function(s) {
    const doubled = s + s;
    const substring = doubled.slice(1, -1);
    return substring.includes(s);
};