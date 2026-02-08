#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> numSmallerByFrequency(vector<string>& queries, vector<string>& words) {
        vector<int> word_freqs;
        for (const string& word : words) {
            word_freqs.push_back(f(word));
        }
        sort(word_freqs.begin(), word_freqs.end());

        vector<int> result;
        for (const string& query : queries) {
            int query_freq = f(query);
            int count = 0;
            for (int freq : word_freqs) {
                if (freq > query_freq) {
                    count++;
                }
            }
            result.push_back(count);
        }
        return result;
    }

private:
    int f(const string& s) {
        if (s.empty()) return 0;
        char smallest = s[0];
        for (char c : s) {
            smallest = min(smallest, c);
        }
        int count = 0;
        for (char c : s) {
            if (c == smallest) {
                count++;
            }
        }
        return count;
    }
};