class Solution {
public:
    vector<int> divisibilityArray(string word, int m) {
        vector<int> result(word.size(), 0);
        long long currentNum = 0;

        for (int i = 0; i < word.size(); i++) {
            currentNum = (currentNum * 10 + (word[i] - '0')) % m;
            if (currentNum == 0) {
                result[i] = 1;
            }
        }

        return result;
    }
};