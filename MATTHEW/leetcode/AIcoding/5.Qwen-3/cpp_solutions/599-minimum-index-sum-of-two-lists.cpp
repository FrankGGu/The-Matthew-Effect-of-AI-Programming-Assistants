#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findRestaurant(vector<string>& list1, vector<string>& list2) {
        unordered_map<string, int> map;
        for (int i = 0; i < list1.size(); ++i) {
            map[list1[i]] = i;
        }
        int minSum = INT_MAX;
        vector<string> result;
        for (int i = 0; i < list2.size(); ++i) {
            if (map.find(list2[i]) != map.end()) {
                int sum = i + map[list2[i]];
                if (sum < minSum) {
                    minSum = sum;
                    result.clear();
                    result.push_back(list2[i]);
                } else if (sum == minSum) {
                    result.push_back(list2[i]);
                }
            }
        }
        return result;
    }
};