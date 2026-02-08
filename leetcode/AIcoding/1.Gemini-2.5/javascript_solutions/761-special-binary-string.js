var makeLargestSpecial = function(s) {
    if (s.length === 0) {
        return "";
    }

    let balance = 0;
    let start = 0;
    const components = [];

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            balance++;
        } else {
            balance--;
        }

        if (balance === 0) {
            // Found a special binary substring from start to i (inclusive)
            // This substring is of the form 1A0, where A is also a special binary string.
            // A is s.substring(start + 1, i)
            const innerSpecialString = makeLargestSpecial(s.substring(start + 1, i));
            components.push('1' + innerSpecialString + '0');
            start = i + 1;
        }
    }

    // Sort components in descending order to get the lexicographically largest string
    components.sort((a, b) => b.localeCompare(a));

    return components.join('');
};