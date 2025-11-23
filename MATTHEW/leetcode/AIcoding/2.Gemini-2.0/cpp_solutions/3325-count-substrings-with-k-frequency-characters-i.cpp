#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, int k) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = s.substr(i, j - i + 1);
                unordered_map<char, int> freq;
                for (char c : sub) {
                    freq[c]++;
                }

                bool valid = false;
                for (auto const& [key, val] : freq) {
                    if (val == k) {
                        valid = true;
                        break;
                    }
                }

                if (valid) {
                    count++;
                }
            }
        }

        return count;
    }
};