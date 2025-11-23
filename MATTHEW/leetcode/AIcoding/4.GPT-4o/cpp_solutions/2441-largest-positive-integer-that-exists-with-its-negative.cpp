#include <vector>
#include <unordered_set>
using namespace std;

int findMaxPositiveInteger(vector<int>& nums) {
    unordered_set<int> numSet;
    int maxNum = -1;

    for (int num : nums) {
        if (num > 0) {
            numSet.insert(num);
        }
    }

    for (int num : numSet) {
        if (numSet.count(-num)) {
            maxNum = max(maxNum, num);
        }
    }

    return maxNum;
}