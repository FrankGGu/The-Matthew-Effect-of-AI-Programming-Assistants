#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int earliestFullBloom(vector<int>& plantTime, vector<int>& growTime) {
        vector<pair<int, int>> pairs;
        for (int i = 0; i < plantTime.size(); ++i) {
            pairs.push_back({growTime[i], plantTime[i]});
        }
        sort(pairs.begin(), pairs.end());
        int result = 0;
        int current = 0;
        for (auto& p : pairs) {
            current += p.second;
            result = max(result, current + p.first);
        }
        return result;
    }
};