#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    int oddEvenJumps(vector<int>& arr) {
        int n = arr.size();
        vector<bool> canReachOdd(n, false), canReachEven(n, false);
        canReachOdd[n - 1] = canReachEven[n - 1] = true;

        map<int, int> indexMap;
        for (int i = 0; i < n; ++i) {
            indexMap[arr[i]] = i;
        }

        vector<int> sortedArr(arr);
        sort(sortedArr.begin(), sortedArr.end());

        vector<int> nextHigher(n, -1), nextLower(n, -1);

        for (int i = 0; i < n; ++i) {
            int val = arr[i];
            auto it = indexMap.find(val);
            if (it != indexMap.end()) {
                int idx = it->second;
                if (idx + 1 < n && sortedArr[idx + 1] > val) {
                    nextHigher[i] = indexMap[sortedArr[idx + 1]];
                }
                if (idx - 1 >= 0 && sortedArr[idx - 1] < val) {
                    nextLower[i] = indexMap[sortedArr[idx - 1]];
                }
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            if (nextHigher[i] != -1) {
                canReachOdd[i] = canReachEven[nextHigher[i]];
            }
            if (nextLower[i] != -1) {
                canReachEven[i] = canReachOdd[nextLower[i]];
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (canReachOdd[i]) {
                result++;
            }
        }
        return result;
    }
};