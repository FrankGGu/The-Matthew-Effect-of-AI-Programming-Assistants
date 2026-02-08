#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSetSize(vector<int>& arr) {
        unordered_map<int, int> counts;
        for (int num : arr) {
            counts[num]++;
        }

        vector<int> frequencies;
        for (auto const& [key, val] : counts) {
            frequencies.push_back(val);
        }

        sort(frequencies.begin(), frequencies.end(), greater<int>());

        int removed = 0;
        int count = 0;
        int n = arr.size();
        int half = (n + 1) / 2;

        for (int freq : frequencies) {
            removed += freq;
            count++;
            if (removed >= half) {
                return count;
            }
        }

        return count;
    }
};