#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numColor(vector<vector<int>>& pictures) {
        unordered_set<int> colors;
        for (const auto& picture : pictures) {
            for (int color : picture) {
                colors.insert(color);
            }
        }
        return colors.size();
    }
};