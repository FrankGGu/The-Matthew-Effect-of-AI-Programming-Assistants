#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumLength(vector<int>& nums) {
        unordered_map<long long, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int max_len = 1;
        for (auto& [num, cnt] : freq) {
            long long current = num;
            if (current == 1) {
                max_len = max(max_len, cnt % 2 == 1 ? cnt : cnt - 1);
                continue;
            }
            int len = 0;
            while (freq.count(current) && freq[current] >= 2) {
                len += 2;
                current *= current;
            }
            if (freq.count(current)) {
                len += 1;
            } else {
                len -= 1;
            }
            max_len = max(max_len, len);
        }
        return max_len;
    }
};