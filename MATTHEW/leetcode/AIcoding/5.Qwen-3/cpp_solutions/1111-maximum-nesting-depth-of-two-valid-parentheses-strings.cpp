#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> maxDepthAfterSplit(string s) {
        vector<int> result(s.size(), 0);
        int depth = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '(') {
                depth++;
                result[i] = depth % 2;
            } else {
                result[i] = depth % 2;
                depth--;
            }
        }
        return result;
    }
};