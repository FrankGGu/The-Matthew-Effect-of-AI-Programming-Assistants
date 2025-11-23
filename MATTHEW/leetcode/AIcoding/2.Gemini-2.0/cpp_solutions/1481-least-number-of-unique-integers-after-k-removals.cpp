#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findLeastNumOfUniqueInts(vector<int>& arr, int k) {
        unordered_map<int, int> counts;
        for (int num : arr) {
            counts[num]++;
        }

        vector<int> frequencies;
        for (auto const& [key, val] : counts) {
            frequencies.push_back(val);
        }

        sort(frequencies.begin(), frequencies.end());

        int removed = 0;
        int uniqueCount = frequencies.size();
        for (int freq : frequencies) {
            if (removed + freq <= k) {
                removed += freq;
                uniqueCount--;
            } else {
                break;
            }
        }

        return uniqueCount;
    }
};