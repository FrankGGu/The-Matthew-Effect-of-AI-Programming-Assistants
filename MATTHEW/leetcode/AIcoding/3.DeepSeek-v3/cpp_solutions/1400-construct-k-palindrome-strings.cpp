class Solution {
public:
    bool canConstruct(string s, int k) {
        if (s.size() < k) return false;
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        int oddCount = 0;
        for (auto& pair : freq) {
            if (pair.second % 2 != 0) {
                oddCount++;
            }
        }
        return oddCount <= k;
    }
};