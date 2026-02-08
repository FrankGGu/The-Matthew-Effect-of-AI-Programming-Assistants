#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> stringMatching(vector<string>& words) {
        vector<string> result;
        for (int i = 0; i < words.size(); ++i) {
            bool found = false;
            for (int j = 0; j < words.size(); ++j) {
                if (i != j && words[i].length() <= words[j].length() && words[j].find(words[i]) != string::npos) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.push_back(words[i]);
            }
        }
        return result;
    }
};