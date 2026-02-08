#include <vector>
#include <set>
#include <map>

class Solution {
public:
    std::vector<int> avoidFlood(std::vector<int>& rains) {
        int n = rains.size();
        std::vector<int> ans(n, 1);
        std::set<int> dry;
        std::map<int, int> full;

        for (int i = 0; i < n; ++i) {
            if (rains[i] > 0) {
                if (full.count(rains[i])) {
                    return {};
                }
                ans[i] = -1;
                full[rains[i]] = i;
                dry.insert(i);
            } else {
                if (dry.empty()) {
                    continue;
                }
                int bestDay = -1;
                int bestLake = -1;
                for (auto it = full.begin(); it != full.end(); ++it) {
                    if (it->second > *dry.begin()) {
                        if (bestDay == -1 || it->second < bestDay) {
                            bestDay = it->second;
                            bestLake = it->first;
                        }
                    }
                }

                if (bestDay == -1) {
                    continue;
                }

                ans[i] = bestLake;
                full.erase(bestLake);
                dry.erase(i);
            }
        }

        return ans;
    }
};