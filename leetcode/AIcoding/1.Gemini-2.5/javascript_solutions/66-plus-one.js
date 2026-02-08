var plusOne = function(digits) {
    const n = digits.length;

    for (let i = n - 1; i >= 0; i--) {
        if (digits[i] < 9) {
            digits[i]++;
            return digits;
        } else {
            digits[i] = 0;
        }
    }

    // If we reach here, it means all digits were 9 (e.g., [9,9,9])
    // We need to add a leading 1
    digits.unshift(1);
    return digits;
};