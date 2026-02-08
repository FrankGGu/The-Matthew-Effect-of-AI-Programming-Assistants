#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> relativeSortArray(vector<int>& arr1, vector<int>& arr2) {
        map<int, int> indexMap;
        for (int i = 0; i < arr2.size(); ++i) {
            indexMap[arr2[i]] = i;
        }

        auto compare = [&](int a, int b) {
            if (indexMap.count(a) && indexMap.count(b)) {
                return indexMap[a] < indexMap[b];
            } else if (indexMap.count(a)) {
                return true;
            } else if (indexMap.count(b)) {
                return false;
            } else {
                return a < b;
            }
        };

        sort(arr1.begin(), arr1.end(), compare);
        return arr1;
    }
};