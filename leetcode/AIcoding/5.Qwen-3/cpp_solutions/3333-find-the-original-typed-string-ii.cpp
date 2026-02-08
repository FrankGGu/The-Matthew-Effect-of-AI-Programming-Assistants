#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string recoverOriginal(string str) {
        int n = str.size();
        string result;
        for (int i = 0; i < n; ) {
            int count = 0;
            while (i < n && str[i] >= '0' && str[i] <= '9') {
                count = count * 10 + (str[i] - '0');
                ++i;
            }
            if (i >= n) break;
            char ch = str[i];
            for (int j = 0; j < count; ++j) {
                result.push_back(ch);
            }
            ++i;
        }
        return result;
    }
};