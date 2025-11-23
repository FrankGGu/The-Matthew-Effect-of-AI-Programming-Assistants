#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countBeautifulPairs(vector<int>& nums) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                string s1 = to_string(nums[i]);
                string s2 = to_string(nums[j]);
                if (gcd(s1[0] - '0', s2.back() - '0') == 1) {
                    count++;
                }
            }
        }
        return count;
    }

private:
    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};