#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long findTheArrayConcVal(vector<int>& nums) {
        long long result = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left <= right) {
            if (left == right) {
                result += nums[left];
                break;
            } else {
                string s1 = to_string(nums[left]);
                string s2 = to_string(nums[right]);
                string concatenated = s1 + s2;
                result += stoll(concatenated);
                left++;
                right--;
            }
        }

        return result;
    }
};