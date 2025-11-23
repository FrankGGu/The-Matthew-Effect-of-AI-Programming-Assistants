#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> relativeSortArray(vector<int>& arr1, vector<int>& arr2) {
        map<int, int> count;
        vector<int> result;
        vector<int> remaining;

        for (int num : arr1) {
            count[num]++;
        }

        for (int num : arr2) {
            if (count.find(num) != count.end()) {
                for (int i = 0; i < count[num]; ++i) {
                    result.push_back(num);
                }
                count.erase(num);
            }
        }

        for (auto const& [key, val] : count) {
            for (int i = 0; i < val; ++i) {
                remaining.push_back(key);
            }
        }

        sort(remaining.begin(), remaining.end());

        result.insert(result.end(), remaining.begin(), remaining.end());

        return result;
    }
};