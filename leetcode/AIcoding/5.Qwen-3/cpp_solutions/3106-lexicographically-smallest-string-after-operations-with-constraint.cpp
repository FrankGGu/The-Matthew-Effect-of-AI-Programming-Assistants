#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string lexSmallestString(string s, string* ops) {
        int n = s.size();
        vector<int> opIndex;
        for (int i = 0; i < n; ++i) {
            if (ops[0][i] == '1') {
                opIndex.push_back(i);
            }
        }

        string result = s;
        for (int i = 0; i < n; ++i) {
            if (ops[0][i] == '1') {
                string temp = s;
                for (int j = i; j < n; ++j) {
                    if (ops[0][j] == '1') {
                        temp[j] = 'a' + (temp[j] - 'a' + 1) % 26;
                    }
                }
                if (temp < result) {
                    result = temp;
                }
            }
        }

        return result;
    }
};