class Solution {
public:
    int maxConsecutiveAnswers(string answerKey, int k) {
        int maxLength = 0, countT = 0, countF = 0;
        int left = 0;

        for (int right = 0; right < answerKey.size(); ++right) {
            if (answerKey[right] == 'T') countT++;
            else countF++;

            while (min(countT, countF) > k) {
                if (answerKey[left] == 'T') countT--;
                else countF--;
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};