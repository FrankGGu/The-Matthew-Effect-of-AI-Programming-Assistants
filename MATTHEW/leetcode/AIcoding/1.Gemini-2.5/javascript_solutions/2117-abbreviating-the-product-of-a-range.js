var abbreviateProduct = function(left, right) {
    let trailingZeros = 0;
    let suffix = 1n; // Using BigInt for suffix to handle large numbers precisely for last digits
    let logSum = 0; // For calculating the number of digits and first digits

    // A sufficiently large modulo to keep track of enough trailing digits
    // We need at least 5 digits, so 10^12 is chosen to ensure we have enough digits
    // even after divisions by 10 and before final modulo 10^5.
    const SUFFIX_MODULO_THRESHOLD = 1000000000000n; // 10^12

    for (let i = left; i <= right; i++) {
        logSum += Math.log10(i);
        suffix *= BigInt(i);

        // Remove trailing zeros and count them
        while (suffix % 10n === 0n) {
            suffix /= 10n;
            trailingZeros++;
        }

        // Keep suffix manageable by taking modulo
        if (suffix > SUFFIX_MODULO_THRESHOLD) {
            suffix %= SUFFIX_MODULO_THRESHOLD;
        }
    }

    // Total number of digits in the original product
    const totalDigits = Math.floor(logSum) + 1;

    // Case 1: Product has 10 digits or less
    if (totalDigits <= 10) {
        let actualProduct = 1n;
        for (let i = left; i <= right; i++) {
            actualProduct *= BigInt(i);
        }
        return actualProduct.toString();
    }

    // Case 2: Product has more than 10 digits
    // Calculate first 5 digits
    const firstDigitsFloat = Math.pow(10, logSum - Math.floor(logSum));
    const first5Str = Math.floor(firstDigitsFloat * 10000).toString(); // Get 5 digits

    // Calculate last 5 digits (after removing trailing zeros)
    const last5Val = suffix % 100000n; // Get the last 5 digits
    let last5Str = last5Val.toString();
    // Pad with leading zeros if necessary
    while (last5Str.length < 5) {
        last5Str = '0' + last5Str;
    }

    return `${first5Str}...${last5Str}e${trailingZeros}`;
};