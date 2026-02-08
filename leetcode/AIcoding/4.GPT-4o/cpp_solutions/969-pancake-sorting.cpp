#include <vector>
using namespace std;

class Solution {
public:
    vector<int> pancakeSort(vector<int>& arr) {
        vector<int> result;
        int n = arr.size();
        for (int i = n; i > 1; --i) {
            int maxIndex = max_element(arr.begin(), arr.begin() + i) - arr.begin();
            if (maxIndex + 1 == i) continue;
            if (maxIndex != 0) {
                result.push_back(maxIndex + 1);
                reverse(arr.begin(), arr.begin() + maxIndex + 1);
            }
            result.push_back(i);
            reverse(arr.begin(), arr.begin() + i);
        }
        return result;
    }
};