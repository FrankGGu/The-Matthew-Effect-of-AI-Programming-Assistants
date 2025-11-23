#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sumOfEncryptedInt(vector<int>& nums) {
        long long sum = 0;
        for (int num : nums) {
            string s = to_string(num);
            int len = s.length();
            string encrypted(len, '9');
            sum += stoll(encrypted);
        }
        return sum;
    }
};