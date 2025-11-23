class Solution {
public:
    bool equalFrequency(string word) {
        int freq[26] = {0};
        for (char c : word) {
            freq[c - 'a']++;
        }
        for (int i = 0; i < 26; ++i) {
            if (freq[i] == 0) continue;
            freq[i]--;
            int common = -1;
            bool valid = true;
            for (int j = 0; j < 26; ++j) {
                if (freq[j] == 0) continue;
                if (common == -1) {
                    common = freq[j];
                } else if (freq[j] != common) {
                    valid = false;
                    break;
                }
            }
            if (valid) return true;
            freq[i]++;
        }
        return false;
    }
};