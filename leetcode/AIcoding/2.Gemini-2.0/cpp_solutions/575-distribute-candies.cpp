#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int distributeCandies(vector<int>& candyType) {
        unordered_set<int> uniqueCandies(candyType.begin(), candyType.end());
        return min(uniqueCandies.size(), candyType.size() / 2);
    }
};