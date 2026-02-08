#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPrime(int num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false;
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) return false;
        }
        return true;
    }

    int maximumPrimeDifference(vector<int>& nums) {
        int first = -1, last = -1;
        for (int i = 0; i < nums.size(); ++i) {
            if (isPrime(nums[i])) {
                if (first == -1) {
                    first = i;
                }
                last = i;
            }
        }
        return last - first;
    }
};