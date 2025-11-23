#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numFriendRequests(vector<int>& ages) {
        int n = ages.size();
        sort(ages.begin(), ages.end());
        int count = 0;
        for (int i = 0; i < n; ++i) {
            int age = ages[i];
            int lowerBound = age / 2 + 7;
            int upperBound = age;
            int lowerIndex = upper_bound(ages.begin(), ages.end(), lowerBound) - ages.begin();
            int upperIndex = upper_bound(ages.begin(), ages.end(), upperBound) - ages.begin();
            count += max(0, upperIndex - lowerIndex - (ages[i] == ages[i]));
        }
        return count;
    }
};