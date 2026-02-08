class Solution {
public:
    string compressedString(string word) {
        string res;
        int n = word.size();
        if (n == 0) return res;

        char prev = word[0];
        int count = 1;

        for (int i = 1; i < n; ++i) {
            if (word[i] == prev) {
                count++;
            } else {
                res += to_string(count) + prev;
                prev = word[i];
                count = 1;
            }
        }
        res += to_string(count) + prev;

        return res;
    }
};