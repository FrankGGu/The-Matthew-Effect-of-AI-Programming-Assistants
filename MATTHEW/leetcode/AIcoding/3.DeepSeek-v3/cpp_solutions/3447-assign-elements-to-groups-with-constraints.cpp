#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canDistribute(vector<int>& nums, vector<int>& quantity) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        vector<int> counts;
        for (auto& pair : freq) {
            counts.push_back(pair.second);
        }
        sort(quantity.rbegin(), quantity.rend());
        return backtrack(counts, quantity, 0);
    }

private:
    bool backtrack(vector<int>& counts, vector<int>& quantity, int index) {
        if (index == quantity.size()) {
            return true;
        }
        for (int& count : counts) {
            if (count >= quantity[index]) {
                count -= quantity[index];
                if (backtrack(counts, quantity, index + 1)) {
                    return true;
                }
                count += quantity[index];
            }
        }
        return false;
    }
};