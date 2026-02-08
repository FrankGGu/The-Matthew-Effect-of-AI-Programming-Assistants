#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    long long minTimeToBrewPotions(vector<int>& potions, long long target) {
        long long left = 1;
        long long right = *max_element(potions.begin(), potions.end()) * target;
        long long answer = right;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long total = 0;
            for (int potion : potions) {
                total += mid / potion;
                if (total >= target) {
                    break;
                }
            }
            if (total >= target) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return answer;
    }
};