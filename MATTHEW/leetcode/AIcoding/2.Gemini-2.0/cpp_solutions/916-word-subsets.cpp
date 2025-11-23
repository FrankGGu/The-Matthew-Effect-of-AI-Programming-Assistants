#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> wordSubsets(vector<string>& A, vector<string>& B) {
        vector<int> maxFreq(26, 0);
        for (string b : B) {
            vector<int> freq(26, 0);
            for (char c : b) {
                freq[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                maxFreq[i] = max(maxFreq[i], freq[i]);
            }
        }

        vector<string> res;
        for (string a : A) {
            vector<int> freq(26, 0);
            for (char c : a) {
                freq[c - 'a']++;
            }
            bool valid = true;
            for (int i = 0; i < 26; i++) {
                if (freq[i] < maxFreq[i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                res.push_back(a);
            }
        }

        return res;
    }
};