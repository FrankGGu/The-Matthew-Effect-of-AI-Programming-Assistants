var maxDiff = function(num) {
    const s = String(num);
    let maxStr = s;
    let minStr = s;

    // Calculate max_num
    let firstNonNine = '';
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== '9') {
            firstNonNine = s[i];
            break;
        }
    }
    if (firstNonNine !== '') {
        maxStr = s.split(firstNonNine).join('9');
    }

    // Calculate min_num
    const firstDigit = s[0];
    if (firstDigit !== '1') {
        minStr = s.split(firstDigit).join('0');
    } else {
        // If the first digit is '1', we need to find the first digit that is not '0' or '1'
        // and change it to '0'. If all digits are '1' or '0' (and the first is '1'),
        // we can't make it smaller by changing '1' to '0' (as it's the first digit)
        // or by changing '0' to '0'.
        // The rule is to change the FIRST digit to '0'.
        // If the first digit is already '1', we can't change it to '0' to make it smaller.
        // We should change the first non-'0' or non-'1' digit to '0'.
        // No, the problem states "choose a digit x (0-9) and replace all occurrences of x with another digit y (0-9)".
        // To minimize, we should change the first digit of the number to '0'.
        // If the first digit is '1', we change all '1's to '0'.
        // Example: 123 -> 023
        // Example: 100 -> 000
        // The logic for `minStr` is simply to take the first digit `s[0]` and replace all occurrences of it with '0'.
        // This is always the correct strategy for minimization.
        minStr = s.split(firstDigit).join('0');
    }

    return parseInt(maxStr) - parseInt(minStr);
};