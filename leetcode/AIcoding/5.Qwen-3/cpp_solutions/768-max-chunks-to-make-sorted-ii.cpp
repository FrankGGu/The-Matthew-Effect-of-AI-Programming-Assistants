#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxChunksToMakeSorted(vector<int>& arr) {
        unordered_map<int, int> count;
        int res = 0;
        int sortedIndex = 0;
        for (int i = 0; i < arr.size(); ++i) {
            count[arr[i]]++;
            if (count[arr[i]] == 1) {
                sortedIndex++;
            }
            if (count[arr[i]] == 0) {
                sortedIndex--;
            }
            if (sortedIndex == 0) {
                res++;
            }
        }
        return res;
    }
};