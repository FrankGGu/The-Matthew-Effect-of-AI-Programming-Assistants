#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int countCompleteSubstrings(string word, int k) {
        int n = word.size();
        int count = 0;

        for (int len = k; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                string sub = word.substr(i, len);
                map<char, int> freq;
                for (char c : sub) {
                    freq[c]++;
                }

                bool complete = true;
                for (auto const& [key, val] : freq) {
                    if (val != k) {
                        complete = false;
                        break;
                    }
                }

                if (complete && freq.size() * k == len) {
                    bool valid = true;
                    for (int j = 0; j < len - 1; ++j) {
                        if (abs(sub[j] - sub[j+1]) > 2) {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};