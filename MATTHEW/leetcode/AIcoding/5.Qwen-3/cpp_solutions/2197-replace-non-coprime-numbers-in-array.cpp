#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> replaceNonCoprimeNumbersInArray(vector<int>& nums) {
        vector<int> result;
        for (int num : nums) {
            while (!result.empty() && gcd(result.back(), num) > 1) {
                int last = result.back();
                result.pop_back();
                num = gcd(last, num);
            }
            result.push_back(num);
        }
        return result;
    }

private:
    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};