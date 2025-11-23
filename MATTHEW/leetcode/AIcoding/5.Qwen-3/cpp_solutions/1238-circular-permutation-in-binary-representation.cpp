#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> circularPermutation(int n, int start) {
        vector<int> result;
        unordered_set<int> visited;
        result.push_back(start);
        visited.insert(start);

        for (int i = 0; i < (1 << n) - 1; ++i) {
            for (int j = 0; j < n; ++j) {
                int next = result.back() ^ (1 << j);
                if (visited.find(next) == visited.end()) {
                    result.push_back(next);
                    visited.insert(next);
                    break;
                }
            }
        }

        return result;
    }
};