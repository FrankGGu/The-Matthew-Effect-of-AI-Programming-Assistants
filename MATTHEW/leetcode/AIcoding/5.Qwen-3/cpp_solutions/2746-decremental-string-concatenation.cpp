#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string minimizeConcatenation(vector<string>& a, vector<string>& b) {
        int n = a.size();
        string res;
        for (int i = 0; i < n; ++i) {
            if (a[i] == b[i]) {
                continue;
            }
            res += a[i];
            res += b[i];
        }
        return res;
    }
};