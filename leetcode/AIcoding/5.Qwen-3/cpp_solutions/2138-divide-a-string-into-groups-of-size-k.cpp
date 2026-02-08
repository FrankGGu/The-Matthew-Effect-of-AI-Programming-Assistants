#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> splitWordsBySizeK(string s, int k) {
        vector<string> result;
        int n = s.length();
        for (int i = 0; i < n; i += k) {
            string group = s.substr(i, k);
            result.push_back(group);
        }
        return result;
    }
};