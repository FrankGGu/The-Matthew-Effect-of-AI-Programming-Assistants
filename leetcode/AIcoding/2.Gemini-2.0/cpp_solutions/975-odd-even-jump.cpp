#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int oddEvenJumps(vector<int>& arr) {
        int n = arr.size();
        vector<bool> odd(n, false);
        vector<bool> even(n, false);
        odd[n - 1] = even[n - 1] = true;
        int ans = 1;

        map<int, int> sorted_arr;
        sorted_arr[arr[n - 1]] = n - 1;

        for (int i = n - 2; i >= 0; i--) {
            auto it = sorted_arr.lower_bound(arr[i]);
            if (it != sorted_arr.end()) {
                odd[i] = even[it->second];
            }

            it = sorted_arr.upper_bound(arr[i]);
            if (it != sorted_arr.begin()) {
                it--;
                even[i] = odd[it->second];
            }

            if (odd[i]) {
                ans++;
            }
            sorted_arr[arr[i]] = i;
        }

        return ans;
    }
};