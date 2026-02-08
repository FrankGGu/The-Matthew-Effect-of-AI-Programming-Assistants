#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxFreq(string s, int maxLetters, int minSize, int maxSize) {
        unordered_map<string, int> freq;
        int n = s.length();
        int max_freq = 0;

        for (int i = 0; i <= n - minSize; ++i) {
            string sub = s.substr(i, minSize);
            unordered_map<char, int> char_count;
            int distinct_chars = 0;

            for (char c : sub) {
                if (char_count.find(c) == char_count.end()) {
                    distinct_chars++;
                }
                char_count[c]++;
            }

            if (distinct_chars <= maxLetters) {
                freq[sub]++;
                max_freq = max(max_freq, freq[sub]);
            }
        }

        return max_freq;
    }
};