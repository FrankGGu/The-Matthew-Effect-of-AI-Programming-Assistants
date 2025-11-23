#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> mostVisited(int n, vector<int>& rounds) {
        int start = rounds[0];
        int end = rounds[rounds.size() - 1];
        vector<int> result;

        if (start <= end) {
            for (int i = start; i <= end; ++i) {
                result.push_back(i);
            }
        } else {
            for (int i = 1; i <= end; ++i) {
                result.push_back(i);
            }
            for (int i = start; i <= n; ++i) {
                result.push_back(i);
            }
            sort(result.begin(), result.end());

        }
        return result;
    }
};