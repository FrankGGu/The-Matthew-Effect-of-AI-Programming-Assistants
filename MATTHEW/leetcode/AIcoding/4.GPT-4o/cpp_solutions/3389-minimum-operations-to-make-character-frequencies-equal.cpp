class Solution {
public:
    int minOperations(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        sort(freq.begin(), freq.end(), greater<int>());

        int operations = 0;
        int target = freq[0];

        for (int i = 1; i < 26 && freq[i] > 0; i++) {
            operations += freq[i] - target + 1;
            target--;
        }

        return operations;
    }
};