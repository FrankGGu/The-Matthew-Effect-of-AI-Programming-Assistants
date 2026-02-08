#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> distanceHouses(vector<int>& s) {
        unordered_map<int, int> count;
        for (int i = 0; i < s.size(); ++i) {
            for (int j = i + 1; j < s.size(); ++j) {
                int dist = abs(s[i] - s[j]);
                count[dist]++;
            }
        }
        vector<int> result;
        for (int i = 1; i <= 1000; ++i) {
            result.push_back(count[i]);
        }
        return result;
    }
};