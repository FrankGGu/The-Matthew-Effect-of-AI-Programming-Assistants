#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxEqualFreq(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> freq;
        unordered_map<int, int> count;
        int maxFreq = 0;
        int ans = 0;

        for (int i = 0; i < n; ++i) {
            int num = nums[i];

            if (freq.count(num)) {
                count[freq[num]]--;
                if (count[freq[num]] == 0) {
                    count.erase(freq[num]);
                }
            }

            freq[num]++;
            count[freq[num]]++;
            maxFreq = max(maxFreq, freq[num]);

            if (count.size() == 1) {
                if (count.count(1) || count.count(maxFreq)) {
                    ans = i + 1;
                }
            } else if (count.size() == 2) {
                if (count.count(1) && count[1] == 1) {
                    ans = i + 1;
                } else if (count.count(maxFreq) && count[maxFreq] == 1 && count.count(maxFreq - 1)) {
                    ans = i + 1;
                }
            }
        }

        return ans;
    }
};