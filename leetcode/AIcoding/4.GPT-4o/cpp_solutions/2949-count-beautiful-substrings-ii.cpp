class Solution {
public:
    int beautifulSubstrings(string s) {
        int n = s.size();
        int count = 0;
        unordered_map<int, int> freq;
        freq[0] = 1; // To account for empty substring

        int currentCount = 0;

        for (int i = 0; i < n; ++i) {
            currentCount += (s[i] == '1' ? 1 : -1);
            count += freq[currentCount];
            freq[currentCount]++;
        }

        return count;
    }
};