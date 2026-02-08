#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int toyCount(vector<int>& toys, int k) {
        sort(toys.begin(), toys.end());
        int count = 0;
        int sum = 0;
        for (int toy : toys) {
            if (sum + toy <= k) {
                sum += toy;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};