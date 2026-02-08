#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findLeastNumOfUniqueInts(std::vector<int>& arr, int k) {
        std::unordered_map<int, int> counts;
        for (int num : arr) {
            counts[num]++;
        }

        std::vector<int> frequencies;
        frequencies.reserve(counts.size());
        for (const auto& pair : counts) {
            frequencies.push_back(pair.second);
        }

        std::sort(frequencies.begin(), frequencies.end());

        int unique_count = frequencies.size();
        for (int freq : frequencies) {
            if (k >= freq) {
                k -= freq;
                unique_count--;
            } else {
                break;
            }
        }

        return unique_count;
    }
};