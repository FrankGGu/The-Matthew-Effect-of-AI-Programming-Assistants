#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> getModifiedArray(int length, vector<vector<int>>& updates) {
        vector<int> result(length, 0);
        for (const auto& update : updates) {
            int start = update[0];
            int end = update[1];
            int inc = update[2];
            result[start] += inc;
            if (end + 1 < length) {
                result[end + 1] -= inc;
            }
        }
        for (int i = 1; i < length; ++i) {
            result[i] += result[i - 1];
        }
        return result;
    }
};