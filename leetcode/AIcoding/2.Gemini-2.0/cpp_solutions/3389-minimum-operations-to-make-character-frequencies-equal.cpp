#include <vector>
#include <algorithm>
#include <numeric>
#include <map>

using namespace std;

class Solution {
public:
    int minOperations(string s) {
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto const& [key, val] : freq) {
            counts.push_back(val);
        }

        int n = counts.size();
        int ans = s.length();

        for (int targetFreq = 1; targetFreq <= s.length(); ++targetFreq) {
            int currOps = 0;
            vector<int> diff;
            for (int count : counts) {
                if (count > targetFreq) {
                    currOps += (count - targetFreq);
                } else if (count < targetFreq) {
                    diff.push_back(count);
                }
            }

            sort(diff.begin(), diff.end(), greater<int>());

            int remaining = 0;
            for (int i = 1; ; ++i) {
                remaining = i * (i - 1) / 2;
                if (remaining >= targetFreq)
                    break;
            }

            int diff_sum = 0;
            for(int d : diff){
                diff_sum += d;
            }

            int needed = 0;
            if(diff_sum < (long long)targetFreq * n - currOps - diff_sum){
                 needed = (long long)targetFreq * n - currOps - diff_sum - diff_sum;
            }

            if(needed > 0){
                continue;
            }

            ans = min(ans, currOps);
        }

        return ans;
    }
};