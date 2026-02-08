class Solution {
public:
    string customSortString(string order, string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        string result;
        for (char c : order) {
            if (freq.find(c) != freq.end()) {
                result.append(freq[c], c);
                freq.erase(c);
            }
        }

        for (auto& pair : freq) {
            result.append(pair.second, pair.first);
        }

        return result;
    }
};