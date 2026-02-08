#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> commonChars(vector<string>& words) {
        vector<int> common(26, 0);
        for (int i = 0; i < 26; ++i) {
            common[i] = INT_MAX;
        }

        for (const string& word : words) {
            vector<int> count(26, 0);
            for (char c : word) {
                count[c - 'a']++;
            }
            for (int i = 0; i < 26; ++i) {
                common[i] = min(common[i], count[i]);
            }
        }

        vector<string> result;
        for (int i = 0; i < 26; ++i) {
            if (common[i] > 0) {
                string s(common[i], 'a' + i);
                result.push_back(s);
            }
        }

        return result;
    }
};