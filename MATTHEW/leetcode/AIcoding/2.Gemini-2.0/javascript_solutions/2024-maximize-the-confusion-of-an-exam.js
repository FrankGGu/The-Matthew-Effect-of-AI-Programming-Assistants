var maxConsecutiveAnswers = function(answerKey, k) {
    let maxLen = 0;
    let n = answerKey.length;

    function solve(char) {
        let left = 0;
        let flips = 0;
        let maxLength = 0;

        for (let right = 0; right < n; right++) {
            if (answerKey[right] !== char) {
                flips++;
            }

            while (flips > k) {
                if (answerKey[left] !== char) {
                    flips--;
                }
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }

    return Math.max(solve('T'), solve('F'));
};