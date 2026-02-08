#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minSetSize(std::vector<int>& arr) {
        std::unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        std::vector<int> frequencies;
        for (auto& pair : count) {
            frequencies.push_back(pair.second);
        }

        std::sort(frequencies.begin(), frequencies.end(), std::greater<int>());

        int total = 0;
        int result = 0;
        for (int freq : frequencies) {
            total += freq;
            result++;
            if (total >= arr.size() / 2) {
                break;
            }
        }

        return result;
    }
};