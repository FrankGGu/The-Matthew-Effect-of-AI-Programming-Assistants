#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> pancakeSort(vector<int>& arr) {
        vector<int> flips;
        int n = arr.size();

        for (int i = n; i > 1; --i) {
            int max_index = 0;
            for (int j = 1; j < i; ++j) {
                if (arr[j] > arr[max_index]) {
                    max_index = j;
                }
            }

            if (max_index != i - 1) {
                if (max_index != 0) {
                    reverse(arr.begin(), arr.begin() + max_index + 1);
                    flips.push_back(max_index + 1);
                }
                reverse(arr.begin(), arr.begin() + i);
                flips.push_back(i);
            }
        }

        return flips;
    }
};