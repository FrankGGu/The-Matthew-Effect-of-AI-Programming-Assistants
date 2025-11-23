#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> relativeSortArray(std::vector<int>& arr1, std::vector<int>& arr2) {
        int counts[1001] = {0};

        for (int num : arr1) {
            counts[num]++;
        }

        std::vector<int> result;
        result.reserve(arr1.size());

        for (int num : arr2) {
            while (counts[num] > 0) {
                result.push_back(num);
                counts[num]--;
            }
        }

        for (int i = 0; i <= 1000; ++i) {
            while (counts[i] > 0) {
                result.push_back(i);
                counts[i]--;
            }
        }

        return result;
    }
};