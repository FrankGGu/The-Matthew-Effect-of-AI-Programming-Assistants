#include <vector>
using namespace std;

class Solution {
public:
    int distributeCandies(int candies, int numChildren) {
        int rounds = 0;
        while (candies > 0) {
            rounds++;
            int give = rounds * numChildren;
            if (candies < give) {
                rounds--;
                break;
            }
            candies -= give;
        }
        return rounds * numChildren + (candies / (rounds + 1)) + min(candies % (rounds + 1), rounds + 1);
    }
};