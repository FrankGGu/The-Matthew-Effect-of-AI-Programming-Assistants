class Solution {
public:
    int similarPairs(vector<string>& words) {
        unordered_map<string, int> freq;
        for (string& word : words) {
            set<char> uniqueChars(word.begin(), word.end());
            string key(uniqueChars.begin(), uniqueChars.end());
            freq[key]++;
        }
        int count = 0;
        for (auto& [key, cnt] : freq) {
            count += cnt * (cnt - 1) / 2;
        }
        return count;
    }
};