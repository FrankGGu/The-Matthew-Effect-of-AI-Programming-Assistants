#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxChunksToMakeSorted(vector<int>& arr) {
        int maxSoFar = 0, chunks = 0;
        for (int i = 0; i < arr.size(); ++i) {
            maxSoFar = max(maxSoFar, arr[i]);
            if (maxSoFar == i) {
                ++chunks;
            }
        }
        return chunks;
    }
};