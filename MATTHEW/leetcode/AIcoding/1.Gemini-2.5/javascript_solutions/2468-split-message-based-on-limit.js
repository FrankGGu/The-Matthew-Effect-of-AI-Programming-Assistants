var splitMessage = function(message, limit) {
    const messageLen = message.length;

    function getSumOfDigitLengths(n) {
        let sum = 0;
        let numDigits = 1;
        let count = 9;
        let currentPowerOf10 = 1;

        while (n >= currentPowerOf10 * 10) {
            sum += count * numDigits;
            currentPowerOf10 *= 10;
            count *= 10;
            numDigits++;
        }
        sum += (n - currentPowerOf10 + 1) * numDigits;
        return sum;
    }

    for (let n = 1; n <= messageLen; n++) {
        const lenN = String(n).length;

        if (limit - (1 + lenN + 3) < 0) {
            break;
        }

        const sumLi = getSumOfDigitLengths(n);
        const totalSuffixLength = sumLi + n * lenN + n * 3;
        const totalContentCapacity = n * limit - totalSuffixLength;

        if (totalContentCapacity >= messageLen) {
            const result = [];
            let currentMessageIndex = 0;
            for (let i = 1; i <= n; i++) {
                const suffix = `{${i}/${n}}`;
                const suffixLen = suffix.length;
                const contentLen = limit - suffixLen;

                const partContent = message.substring(currentMessageIndex, currentMessageIndex + contentLen);
                result.push(partContent + suffix);
                currentMessageIndex += contentLen;
            }
            return result;
        }
    }

    return [];
};