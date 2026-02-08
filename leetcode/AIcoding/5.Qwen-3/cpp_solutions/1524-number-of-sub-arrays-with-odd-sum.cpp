#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numOfSubarrays(vector<int>& arr) {
        int n = arr.size();
        int mod0 = 1, mod1 = 0;
        int sum = 0;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            sum += arr[i];
            if (sum % 2 == 0) {
                result = (result + mod1) % 1000000007;
                mod0 = (mod0 + 1) % 1000000007;
            } else {
                result = (result + mod0) % 1000000007;
                mod1 = (mod1 + 1) % 1000000007;
            }
        }
        return result;
    }
};