#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findKey(vector<int>& numbers) {
        int n = numbers.size();
        if (n == 0) return 0;

        vector<int> counts(10, 0);
        for (int num : numbers) {
            counts[num]++;
        }

        int maxCount = 0;
        int key = 0;
        for (int i = 0; i < 10; ++i) {
            if (counts[i] > maxCount) {
                maxCount = counts[i];
                key = i;
            }
        }

        return key;
    }
};