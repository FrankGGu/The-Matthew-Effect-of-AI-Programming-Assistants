#include <vector>
using namespace std;

class Solution {
public:
    vector<int> separateDigits(vector<int>& nums) {
        vector<int> result;
        for (int num : nums) {
            string strNum = to_string(num);
            for (char digit : strNum) {
                result.push_back(digit - '0');
            }
        }
        return result;
    }
};