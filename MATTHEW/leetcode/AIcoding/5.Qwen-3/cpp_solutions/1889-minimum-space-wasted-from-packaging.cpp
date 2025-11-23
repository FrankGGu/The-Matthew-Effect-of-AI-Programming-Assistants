#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minSpaceWastedKResizing(vector<int>& packages, vector<int>& boxes) {
        sort(packages.begin(), packages.end());
        sort(boxes.begin(), boxes.end());

        int n = packages.size();
        int m = boxes.size();
        vector<int> result;

        for (int k = 1; k <= m; ++k) {
            vector<int> boxSubset(boxes.begin(), boxes.begin() + k);
            sort(boxSubset.begin(), boxSubset.end());

            int totalWaste = 0;
            int j = 0;
            for (int i = 0; i < n; ++i) {
                while (j < k && boxSubset[j] < packages[i]) {
                    ++j;
                }
                if (j < k) {
                    totalWaste += boxSubset[j] - packages[i];
                } else {
                    break;
                }
            }
            result.push_back(totalWaste);
        }

        return result;
    }
};