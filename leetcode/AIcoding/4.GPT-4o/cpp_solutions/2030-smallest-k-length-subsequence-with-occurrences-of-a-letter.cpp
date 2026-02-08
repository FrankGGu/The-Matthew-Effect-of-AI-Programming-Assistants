class Solution {
public:
    string smallestSubsequence(string s, int k, char letter, int repetition) {
        int n = s.size();
        string result;
        int count = 0, remaining = repetition;

        vector<int> letterCount(n + 1, 0);
        for (char c : s) {
            letterCount[c]++;
        }

        for (char c : s) {
            while (!result.empty() && result.back() > c && 
                   (result.size() - (result.back() == letter ? 1 : 0) + letterCount[result.back()] > k) &&
                   (result.size() + letterCount[c] > k || (result.back() != letter && remaining > 0))) {
                if (result.back() == letter) remaining++;
                result.pop_back();
            }
            if (result.size() < k) {
                if (c == letter) {
                    result.push_back(c);
                    remaining--;
                } else if (remaining < repetition || result.size() < k - repetition) {
                    result.push_back(c);
                }
            }
            letterCount[c]--;
        }

        return result;
    }
};