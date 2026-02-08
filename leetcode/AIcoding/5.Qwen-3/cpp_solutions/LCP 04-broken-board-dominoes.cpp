#include <iostream>
#include <vector>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int minDominoRotations(vector<int>& tops, vector<int>& bottoms) {
        int n = tops.size();
        unordered_map<int, int> topCount;
        unordered_map<int, int> bottomCount;
        unordered_map<int, int> sameCount;

        for (int i = 0; i < n; ++i) {
            topCount[tops[i]]++;
            bottomCount[bottoms[i]]++;
            if (tops[i] == bottoms[i]) {
                sameCount[tops[i]]++;
            }
        }

        int result = n + 1;
        for (int i = 1; i <= 6; ++i) {
            if (topCount[i] + bottomCount[i] - sameCount[i] == n) {
                result = min(result, min(topCount[i], bottomCount[i]));
            }
        }

        return result == n + 1 ? -1 : result;
    }
};