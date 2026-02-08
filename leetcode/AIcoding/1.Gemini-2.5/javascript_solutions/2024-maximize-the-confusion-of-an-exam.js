var maxConsecutiveAnswers = function(answerKey, k) {
    const n = answerKey.length;

    function calculateMax(charToMaximize) {
        let left = 0;
        let maxLength = 0;
        let otherCharCount = 0;

        for (let right = 0; right < n; right++) {
            if (answerKey[right] !== charToMaximize) {
                otherCharCount++;
            }

            while (otherCharCount > k) {
                if (answerKey[left] !== charToMaximize) {
                    otherCharCount--;
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
        }
        return maxLength;
    }

    return Math.max(calculateMax('T'), calculateMax('F'));
};