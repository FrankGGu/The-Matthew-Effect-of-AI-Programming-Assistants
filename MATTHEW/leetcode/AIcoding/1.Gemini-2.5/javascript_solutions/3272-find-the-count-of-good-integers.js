function findTheCountOfGoodIntegers(low, high) {
    let count = 0;

    function isGood(num) {
        let hasRotatedDigit = false; // True if the number contains at least one digit that changes upon rotation (2, 5, 6, 9)
        let isValidRotation = true;  // False if the number contains any invalid digits (3, 4, 7)

        let temp = num;
        if (temp === 0) {
            // For problems like LeetCode 788, numbers are usually positive.
            // 0 rotates to 0, which is not considered "different".
            return false;
        }

        while (temp > 0) {
            const digit = temp % 10;
            if (digit === 3 || digit === 4 || digit === 7) {
                isValidRotation = false;
                break;
            }
            if (digit === 2 || digit === 5 || digit === 6 || digit === 9) {
                hasRotatedDigit = true;
            }
            temp = Math.floor(temp / 10);
        }

        // A number is "good" if all its digits can be rotated (no 3, 4, 7)
        // AND the rotated number is different from the original (meaning it must contain at least one 2, 5, 6, or 9).
        return isValidRotation && hasRotatedDigit;
    }

    for (let i = low; i <= high; i++) {
        if (isGood(i)) {
            count++;
        }
    }

    return count;
}