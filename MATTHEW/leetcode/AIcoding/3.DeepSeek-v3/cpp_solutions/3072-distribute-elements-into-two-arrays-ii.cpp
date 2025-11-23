#include <vector>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>

using namespace std;
using namespace __gnu_pbds;

typedef tree<pair<int, int>, null_type, less<pair<int, int>>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;

class Solution {
public:
    vector<int> resultArray(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return {};

        ordered_set set1, set2;
        set1.insert({nums[0], 0});
        set2.insert({nums[1], 1});

        vector<int> arr1 = {nums[0]};
        vector<int> arr2 = {nums[1]};

        for (int i = 2; i < n; ++i) {
            int num = nums[i];
            int cnt1 = set1.size() - set1.order_of_key({num + 1, -1});
            int cnt2 = set2.size() - set2.order_of_key({num + 1, -1});

            if (cnt1 > cnt2) {
                arr1.push_back(num);
                set1.insert({num, i});
            } else if (cnt1 < cnt2) {
                arr2.push_back(num);
                set2.insert({num, i});
            } else {
                if (arr1.size() <= arr2.size()) {
                    arr1.push_back(num);
                    set1.insert({num, i});
                } else {
                    arr2.push_back(num);
                    set2.insert({num, i});
                }
            }
        }

        arr1.insert(arr1.end(), arr2.begin(), arr2.end());
        return arr1;
    }
};