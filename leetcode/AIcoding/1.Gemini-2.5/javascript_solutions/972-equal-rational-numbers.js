var isRationalEqual = function(s, t) {
    const EPSILON = 1e-9; // Epsilon for floating-point comparison

    function parseRationalToFloat(numStr) {
        const parenthesisIndex = numStr.indexOf('(');

        if (parenthesisIndex === -1) {
            // No repeating part, just parse as a standard float
            return parseFloat(numStr);
        }

        let nonRepeatingPart = numStr.substring(0, parenthesisIndex);
        const repeatingPart = numStr.substring(parenthesisIndex + 1, numStr.length - 1);

        // If the non-repeating part is an integer and there's a repeating part,
        // we need to explicitly add a decimal point to form a valid float string.
        if (nonRepeatingPart.indexOf('.') === -1 && repeatingPart.length > 0) {
            nonRepeatingPart += '.';
        }

        let result = nonRepeatingPart;

        // Target enough decimal digits to exceed standard double precision (15-17 digits).
        // The problem constraint "at most 9" total digits makes 20 very safe.
        const targetDecimalDigits = 20; 

        // Calculate current digits after the decimal point in the non-repeating part
        const dotIndex = nonRepeatingPart.indexOf('.');
        let currentDecimalDigits = 0;
        if (dotIndex !== -1) {
            currentDecimalDigits = nonRepeatingPart.length - dotIndex - 1;
        }

        // Append the repeating part until we have enough digits after the decimal point
        while (currentDecimalDigits < targetDecimalDigits) {
            result += repeatingPart;
            currentDecimalDigits += repeatingPart.length;
        }

        // Convert the expanded string to a float
        return parseFloat(result);
    }

    const valS = parseRationalToFloat(s);
    const valT = parseRationalToFloat(t);

    // Compare the two floating-point numbers with an epsilon to account for precision errors
    return Math.abs(valS - valT) < EPSILON;
};