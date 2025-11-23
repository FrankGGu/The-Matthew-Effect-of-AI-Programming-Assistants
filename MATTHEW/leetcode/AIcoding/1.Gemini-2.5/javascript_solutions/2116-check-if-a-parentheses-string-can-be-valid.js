var canBeValid = function(s, locked) {
    const n = s.length;

    // A valid parentheses string must have an even length.
    if (n % 2 !== 0) {
        return false;
    }

    // minOpen: minimum possible balance of open parentheses (if we choose '0's to be ')' as much as possible)
    // maxOpen: maximum possible balance of open parentheses (if we choose '0's to be '(' as much as possible)
    let minOpen = 0;
    let maxOpen = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '(') {
            minOpen++;
            maxOpen++;
        } else if (s[i] === ')') {
            minOpen--;
            maxOpen--;
        } else { // s[i] can be changed because locked[i] === '0'
            minOpen--; // Assume '0' is ')' to get the minimum balance
            maxOpen++; // Assume '0' is '(' to get the maximum balance
        }

        // For any prefix, the balance of open parentheses must not be negative.
        // If minOpen drops below 0, it means we have more ')' than '(',
        // even if we try to make it 0 by converting some flexible '0's (that were assumed to be ')') to '('.
        // So, we reset minOpen to 0 if it goes negative, as we can always choose '0's to keep the balance non-negative if possible.
        minOpen = Math.max(minOpen, 0);

        // If maxOpen drops below 0, it means even if all flexible '0's were chosen to be ')'
        // (to maximize the number of closing parentheses), the balance is still negative.
        // This indicates it's impossible to form a valid prefix, so return false.
        if (maxOpen < 0) {
            return false;
        }
    }

    // After iterating through the entire string, for the string to be valid,
    // the total balance of open parentheses must be exactly 0.
    // If minOpen is 0, it means we can achieve a total balance of 0.
    // If minOpen > 0, it means even if we converted all flexible '0's to ')' to minimize the open count,
    // we still have a positive balance (too many '('). This means it's impossible to make the total balance zero.
    return minOpen === 0;
};