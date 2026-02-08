#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findRestaurant(vector<string>& list1, vector<string>& list2) {
        unordered_map<string, int> map1;
        for (int i = 0; i < list1.size(); ++i) {
            map1[list1[i]] = i;
        }

        int min_sum = INT_MAX;
        vector<string> result;

        for (int i = 0; i < list2.size(); ++i) {
            if (map1.count(list2[i])) {
                int sum = i + map1[list2[i]];
                if (sum < min_sum) {
                    min_sum = sum;
                    result.clear();
                    result.push_back(list2[i]);
                } else if (sum == min_sum) {
                    result.push_back(list2[i]);
                }
            }
        }

        return result;
    }
};