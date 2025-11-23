function isSubstringInReverse(s, sub) {
    const reversed = s.split('').reverse().join('');
    return reversed.includes(sub);
}