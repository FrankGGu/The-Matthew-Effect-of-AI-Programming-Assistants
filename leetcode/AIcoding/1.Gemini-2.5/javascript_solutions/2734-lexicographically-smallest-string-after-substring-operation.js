var lexicographicallySmallestString = function(s) {
    let chars = s.split('');
    let startIdx = -1;

    // Find the index of the first character that is not 'a'
    for (let i = 0; i < chars.length; i++) {
        if (chars[i] !== 'a') {
            startIdx = i;
            break;
        }
    }

    // If all characters in the string are 'a',
    // performing the operation on any substring of 'a's will result in the same 'a's.
    // Thus, the string remains unchanged and is already the lexicographically smallest.
    if (startIdx === -1) {
        return s;
    }

    // Starting from the first non-'a' character,
    // decrement characters until an 'a' is encountered or the end of the string is reached.
    // This forms the substring for the operation.
    for (let i = startIdx; i < chars.length; i++) {
        if (chars[i] === 'a') {
            // If we encounter an 'a', we stop decrementing characters
            // because 'a' cannot be decremented further and including it
            // in the operation would not make the string smaller at this position.
            break;
        }
        // Decrement the character by one in alphabetical order
        chars[i] = String.fromCharCode(chars[i].charCodeAt(0) - 1);
    }

    // Join the modified characters back into a string and return it
    return chars.join('');
};