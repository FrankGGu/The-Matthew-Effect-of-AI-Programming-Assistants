#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestValsFromLabels(vector<int>& values, vector<int>& labels, int numWanted, int useLimit) {
        vector<pair<int, int>> pairs;
        for (int i = 0; i < values.size(); ++i) {
            pairs.push_back({values[i], labels[i]});
        }

        sort(pairs.begin(), pairs.end(), greater<pair<int, int>>());

        int sum = 0;
        int count = 0;
        unordered_map<int, int> labelCount;

        for (auto& p : pairs) {
            if (labelCount[p.second] < useLimit) {
                sum += p.first;
                labelCount[p.second]++;
                count++;
                if (count == numWanted) {
                    break;
                }
            }
        }

        return sum;
    }
};