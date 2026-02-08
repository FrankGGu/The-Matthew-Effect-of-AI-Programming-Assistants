var isSubstringPresent = function(s) {
    const reversed = s.split('').reverse().join('');
    for (let i = 0; i < s.length - 1; i++) {
        const substring = s.substring(i, i + 2);
        if (reversed.includes(substring)) {
            return true;
        }
    }
    return false;
};