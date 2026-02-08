#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> numberOfLines(int n, vector<string>& s) {
        vector<int> result;
        int lines = 0;
        int width = 0;
        for (const string& str : s) {
            int len = str.length();
            if (width + len > n) {
                lines++;
                width = len;
            } else {
                width += len;
            }
        }
        lines++;
        result.push_back(lines);
        result.push_back(width);
        return result;
    }
};