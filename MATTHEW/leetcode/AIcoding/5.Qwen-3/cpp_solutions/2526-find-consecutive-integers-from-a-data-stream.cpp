#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> consecutiveIntegers(vector<int>& data, int k) {
        vector<int> result;
        unordered_map<int, int> countMap;
        int left = 0;

        for (int right = 0; right < data.size(); ++right) {
            countMap[data[right]]++;

            while (countMap.size() > k) {
                countMap[data[left]]--;
                if (countMap[data[left]] == 0) {
                    countMap.erase(data[left]);
                }
                left++;
            }

            if (countMap.size() == k) {
                result.push_back(right - left + 1);
            }
        }

        return result;
    }
};