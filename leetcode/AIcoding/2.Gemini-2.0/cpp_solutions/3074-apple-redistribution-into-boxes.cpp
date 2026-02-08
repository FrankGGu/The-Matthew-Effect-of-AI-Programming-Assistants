#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long redistributeApples(vector<int>& boxSizes, int maxApples) {
        long long sum = accumulate(boxSizes.begin(), boxSizes.end(), 0LL);
        long long neededBoxes = (sum + maxApples - 1) / maxApples;
        return neededBoxes - boxSizes.size();
    }
};