#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        if (nums.size() == 1) return 0;

        unordered_map<int, int> freq0, freq1;
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                freq0[nums[i]]++;
            } else {
                freq1[nums[i]]++;
            }
        }

        auto getTop2 = [](unordered_map<int, int>& freq) {
            vector<pair<int, int>> pairs;
            for (auto& p : freq) {
                pairs.emplace_back(p.second, p.first);
            }
            sort(pairs.rbegin(), pairs.rend());
            if (pairs.size() == 1) {
                return make_pair(pairs[0], make_pair(-1, -1));
            } else {
                return make_pair(pairs[0], pairs[1]);
            }
        };

        auto top0 = getTop2(freq0);
        auto top1 = getTop2(freq1);

        if (top0.first.second != top1.first.second) {
            return nums.size() - top0.first.first - top1.first.first;
        } else {
            int option1 = (top1.second.first == -1) ? INT_MAX : (nums.size() - top0.first.first - top1.second.first);
            int option2 = (top0.second.first == -1) ? INT_MAX : (nums.size() - top0.second.first - top1.first.first);
            return min(option1, option2);
        }
    }
};