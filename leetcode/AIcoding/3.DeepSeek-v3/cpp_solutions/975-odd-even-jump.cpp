#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int oddEvenJumps(vector<int>& arr) {
        int n = arr.size();
        if (n == 0) return 0;

        vector<bool> odd(n, false);
        vector<bool> even(n, false);
        odd[n-1] = even[n-1] = true;

        map<int, int> treeMap;
        treeMap[arr[n-1]] = n-1;

        int res = 1;

        for (int i = n-2; i >= 0; --i) {
            auto itOdd = treeMap.lower_bound(arr[i]);
            if (itOdd != treeMap.end()) {
                odd[i] = even[itOdd->second];
            }

            auto itEven = treeMap.upper_bound(arr[i]);
            if (itEven != treeMap.begin()) {
                --itEven;
                even[i] = odd[itEven->second];
            }

            if (odd[i]) {
                res++;
            }

            treeMap[arr[i]] = i;
        }

        return res;
    }
};