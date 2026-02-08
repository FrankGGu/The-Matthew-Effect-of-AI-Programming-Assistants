#include <vector>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<string> commonChars(vector<string>& A) {
        vector<int> min_freq(26, INT_MAX);
        for (string& s : A) {
            vector<int> freq(26, 0);
            for (char c : s) {
                freq[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                min_freq[i] = min(min_freq[i], freq[i]);
            }
        }

        vector<string> result;
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < min_freq[i]; j++) {
                result.push_back(string(1, (char)('a' + i)));
            }
        }

        return result;
    }
};