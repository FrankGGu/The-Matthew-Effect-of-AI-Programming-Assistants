#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostPopularCreator(const vector<string>& creators, const vector<string>& ids, const vector<int>& views) {
        int n = creators.size();
        vector<pair<string, int>> creatorViews;
        for (int i = 0; i < n; ++i) {
            creatorViews.push_back({creators[i], views[i]});
        }

        sort(creatorViews.begin(), creatorViews.end());

        vector<string> result;
        string currentCreator = "";
        int maxView = -1;
        string bestId = "";

        for (int i = 0; i < n; ++i) {
            if (creators[i] != currentCreator) {
                if (!currentCreator.empty()) {
                    result.push_back(bestId);
                }
                currentCreator = creators[i];
                maxView = views[i];
                bestId = ids[i];
            } else {
                if (views[i] > maxView) {
                    maxView = views[i];
                    bestId = ids[i];
                } else if (views[i] == maxView && ids[i] < bestId) {
                    bestId = ids[i];
                }
            }
        }

        if (!currentCreator.empty()) {
            result.push_back(bestId);
        }

        return result.size();
    }
};