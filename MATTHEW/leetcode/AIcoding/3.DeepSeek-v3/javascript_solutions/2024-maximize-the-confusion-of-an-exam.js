var maxConsecutiveAnswers = function(answerKey, k) {
    const maxConsecutiveChar = (char) => {
        let left = 0, max = 0, count = 0;
        for (let right = 0; right < answerKey.length; right++) {
            if (answerKey[right] !== char) count++;
            while (count > k) {
                if (answerKey[left] !== char) count--;
                left++;
            }
            max = Math.max(max, right - left + 1);
        }
        return max;
    };
    return Math.max(maxConsecutiveChar('T'), maxConsecutiveChar('F'));
};