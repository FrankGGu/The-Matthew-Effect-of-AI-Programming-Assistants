#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> reorderLogFiles(vector<string>& logs) {
        vector<string> letters;
        vector<string> digits;

        for (const string& log : logs) {
            bool isDigit = false;
            for (int i = 0; i < log.size(); ++i) {
                if (log[i] == ' ') {
                    for (int j = i + 1; j < log.size(); ++j) {
                        if (isdigit(log[j])) {
                            isDigit = true;
                            break;
                        }
                    }
                    break;
                }
            }
            if (isDigit) {
                digits.push_back(log);
            } else {
                letters.push_back(log);
            }
        }

        sort(letters.begin(), letters.end(), [](const string& a, const string& b) {
            int i = a.find(' ');
            int j = b.find(' ');
            string aStr = a.substr(i + 1);
            string bStr = b.substr(j + 1);
            if (aStr != bStr) {
                return aStr < bStr;
            }
            return a.substr(0, i) < b.substr(0, j);
        });

        letters.insert(letters.end(), digits.begin(), digits.end());
        return letters;
    }
};