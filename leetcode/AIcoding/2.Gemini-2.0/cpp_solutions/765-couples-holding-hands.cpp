#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwapsCouples(vector<int>& row) {
        int n = row.size();
        int swaps = 0;
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[row[i]] = i;
        }

        for (int i = 0; i < n; i += 2) {
            int first = row[i];
            int second = (first % 2 == 0) ? first + 1 : first - 1;
            if (row[i + 1] != second) {
                swaps++;
                int pos_second = pos[second];
                swap(row[i + 1], row[pos_second]);
                pos[row[i + 1]] = i + 1;
                pos[second] = pos_second;
            }
        }
        return swaps;
    }
};