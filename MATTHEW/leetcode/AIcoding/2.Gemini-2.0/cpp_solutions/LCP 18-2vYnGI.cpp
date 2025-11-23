#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int breakfastNumber(vector<int>& staple, vector<int>& drinks, int x) {
        sort(staple.begin(), staple.end());
        sort(drinks.begin(), drinks.end());

        int count = 0;
        int j = drinks.size() - 1;
        for (int i = 0; i < staple.size(); ++i) {
            while (j >= 0 && staple[i] + drinks[j] > x) {
                --j;
            }
            if (j >= 0) {
                count = (count + j + 1) % 1000000007;
            } else {
                break;
            }
        }

        return count;
    }
};