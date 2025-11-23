#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findLucky(vector<int>& arr) {
        unordered_map<int, int> counts;
        for (int num : arr) {
            counts[num]++;
        }

        int lucky = -1;
        for (auto const& [key, val] : counts) {
            if (key == val) {
                lucky = max(lucky, key);
            }
        }

        return lucky;
    }
};