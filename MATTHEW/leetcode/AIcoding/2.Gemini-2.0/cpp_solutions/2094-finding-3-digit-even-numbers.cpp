#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findEvenNumbers(vector<int>& digits) {
        vector<int> counts(10, 0);
        for (int digit : digits) {
            counts[digit]++;
        }

        vector<int> result;
        for (int i = 100; i <= 999; i += 2) {
            vector<int> numCounts(10, 0);
            int temp = i;
            numCounts[temp % 10]++;
            temp /= 10;
            numCounts[temp % 10]++;
            temp /= 10;
            numCounts[temp % 10]++;

            bool possible = true;
            for (int j = 0; j < 10; ++j) {
                if (numCounts[j] > counts[j]) {
                    possible = false;
                    break;
                }
            }

            if (possible) {
                result.push_back(i);
            }
        }

        return result;
    }
};