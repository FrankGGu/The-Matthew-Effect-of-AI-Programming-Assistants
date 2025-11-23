var isNumber = function(s) {
    s = s.trim();

    let seenDigit = false;
    let seenDot = false;
    let seenE = false;
    let digitAfterE = false;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char >= '0' && char <= '9') {
            seenDigit = true;
            digitAfterE = true;
        } else if (char === '+' || char === '-') {
            // Sign can only appear at the beginning OR immediately after 'e'/'E'
            if (i !== 0 && s[i-1] !== 'e' && s[i-1] !== 'E') {
                return false;
            }
        } else if (char === '.') {
            // Dot can only appear if we haven't seen one yet AND haven't seen 'e'/'E'
            if (seenDot || seenE) {
                return false;
            }
            seenDot = true;
        } else if (char === 'e' || char === 'E') {
            // 'e'/'E' can only appear if we haven't seen one yet AND we've seen at least one digit before it
            if (seenE || !seenDigit) {
                return false;
            }
            seenE = true;
            digitAfterE = false; // Reset for the exponent part, must see digits after 'e'
        } else {
            // Any other character is invalid
            return false;
        }
    }

    // After iterating through the string, check final conditions:
    // 1. Must have seen at least one digit in total.
    // 2. If 'e'/'E' was seen, there must be digits after it.
    return seenDigit && (!seenE || digitAfterE);
};