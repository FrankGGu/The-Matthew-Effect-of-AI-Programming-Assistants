#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string getPermutation(int n, int k) {
        vector<int> nums;
        int fact[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = fact[i - 1] * i;
            nums.push_back(i);
        }

        k--;
        string result = "";
        for (int i = n; i >= 1; i--) {
            int index = k / fact[i - 1];
            result += to_string(nums[index]);
            nums.erase(nums.begin() + index);
            k %= fact[i - 1];
        }

        return result;
    }
};