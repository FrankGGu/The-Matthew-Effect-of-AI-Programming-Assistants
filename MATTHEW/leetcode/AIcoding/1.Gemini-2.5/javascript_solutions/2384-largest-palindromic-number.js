var largestPalindromic = function(num) {
    const counts = new Array(10).fill(0);
    for (let i = 0; i < num.length; i++) {
        counts[parseInt(num[i])]++;
    }

    let middleChar = '';
    // Find the largest digit with an odd count for the center
    for (let d = 9; d >= 0; d--) {
        if (counts[d] % 2 === 1) {
            middleChar = String(d);
            break; // Found the largest, so stop
        }
    }

    let leftHalf = [];
    // Build the left half using pairs of digits, from largest to smallest
    for (let d = 9; d >= 0; d--) {
        // If 'd' is the middleChar, counts[d] is odd, so Math.floor(counts[d]/2) correctly uses (counts[d]-1)/2 pairs.
        // If 'd' is not the middleChar, counts[d] is even, so Math.floor(counts[d]/2) correctly uses counts[d]/2 pairs.
        const halfCount = Math.floor(counts[d] / 2);
        for (let i = 0; i < halfCount; i++) {
            leftHalf.push(String(d));
        }
    }

    // Special handling for `leftHalf` consisting only of '0's.
    // This addresses cases like "010" -> "1" (not "10") and "0000" -> "0".
    // If leftHalf has only one '0' and there's a non-zero middleChar, clear leftHalf.
    // This makes "010" -> "1".
    if (leftHalf.length === 1 && leftHalf[0] === '0' && middleChar !== '' && middleChar !== '0') {
        leftHalf = [];
    } 
    // If leftHalf consists of any number of '0's, and middleChar is empty or '0',
    // then the entire number is "0". This handles "00", "000", "0".
    else if (leftHalf.length > 0 && leftHalf[0] === '0' && (middleChar === '' || middleChar === '0')) {
        return '0';
    }

    let leftHalfStr = leftHalf.join('');
    // Create a copy of leftHalf to reverse for rightHalfStr, as leftHalf might be reused or modified.
    let rightHalfStr = [...leftHalf].reverse().join('');

    let result = leftHalfStr + middleChar + rightHalfStr;

    // Final step: Trim leading zeros from the constructed palindrome string
    // This converts "00500" to "500" and "00900" to "9".
    let firstNonZeroIdx = 0;
    while (firstNonZeroIdx < result.length - 1 && result[firstNonZeroIdx] === '0') {
        firstNonZeroIdx++;
    }

    return result.substring(firstNonZeroIdx);
};