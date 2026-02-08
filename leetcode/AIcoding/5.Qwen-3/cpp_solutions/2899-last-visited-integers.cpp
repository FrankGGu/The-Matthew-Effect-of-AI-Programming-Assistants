#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> getLastVisitedIntegers(vector<string>& words) {
        vector<int> result;
        vector<string> temp;
        for (const string& word : words) {
            if (word.find_first_not_of("0123456789") == string::npos) {
                temp.push_back(word);
            } else {
                if (!temp.empty()) {
                    for (int i = temp.size() - 1; i >= 0; --i) {
                        result.push_back(stoi(temp[i]));
                    }
                    temp.clear();
                }
            }
        }
        if (!temp.empty()) {
            for (int i = temp.size() - 1; i >= 0; --i) {
                result.push_back(stoi(temp[i]));
            }
        }
        return result;
    }
};