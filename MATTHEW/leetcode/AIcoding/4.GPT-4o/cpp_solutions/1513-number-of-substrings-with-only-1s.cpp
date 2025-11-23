class Solution {
public:
    int countBinarySubstrings(string s) {
        vector<int> counts;
        int count = 1;

        for (int i = 1; i < s.size(); i++) {
            if (s[i] == s[i - 1]) {
                count++;
            } else {
                counts.push_back(count);
                count = 1;
            }
        }
        counts.push_back(count);

        int result = 0;
        for (int i = 1; i < counts.size(); i++) {
            result += min(counts[i - 1], counts[i]);
        }

        return result;
    }
};