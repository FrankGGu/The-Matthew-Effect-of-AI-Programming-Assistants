#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getSubsequence(int n, vector<int>& group, vector<int>& profit) {
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (result.empty() || group[i] != group[result.back()]) {
                result.push_back(i);
            }
        }
        return result;
    }
};