#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countBeautifulPairs(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n - 1; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (gcd(firstDigit(nums[i]), lastDigit(nums[j])) == 1) {
                    count++;
                }
            }
        }
        return count;
    }

private:
    int firstDigit(int num) {
        string s = to_string(num);
        return s[0] - '0';
    }

    int lastDigit(int num) {
        return num % 10;
    }

    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};