class Solution {
public:
    int minimumOperationsToMakeKPeriodic(string word, int k) {
        unordered_map<string, int> freq;
        int max_freq = 0;
        int n = word.size();
        for (int i = 0; i <= n - k; i += k) {
            string segment = word.substr(i, k);
            freq[segment]++;
            max_freq = max(max_freq, freq[segment]);
        }
        return (n / k) - max_freq;
    }
};