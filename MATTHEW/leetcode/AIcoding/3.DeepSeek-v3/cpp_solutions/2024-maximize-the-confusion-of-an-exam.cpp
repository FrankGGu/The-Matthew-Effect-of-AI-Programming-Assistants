class Solution {
public:
    int maxConsecutiveAnswers(string answerKey, int k) {
        int max_freq = 0;
        int left = 0;
        int result = 0;
        unordered_map<char, int> count;

        for (int right = 0; right < answerKey.size(); ++right) {
            char current = answerKey[right];
            count[current]++;
            max_freq = max(max_freq, count[current]);

            if (right - left + 1 - max_freq > k) {
                count[answerKey[left]]--;
                left++;
            }

            result = max(result, right - left + 1);
        }

        return result;
    }
};