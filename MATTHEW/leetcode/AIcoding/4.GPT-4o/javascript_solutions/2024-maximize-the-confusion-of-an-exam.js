var maxConsecutiveAnswers = function(answerKey, k) {
    let left = 0, maxCount = 0, countT = 0, countF = 0;

    for (let right = 0; right < answerKey.length; right++) {
        if (answerKey[right] === 'T') countT++;
        else countF++;

        while (Math.min(countT, countF) > k) {
            if (answerKey[left] === 'T') countT--;
            else countF--;
            left++;
        }
        maxCount = Math.max(maxCount, right - left + 1);
    }
    return maxCount;
};