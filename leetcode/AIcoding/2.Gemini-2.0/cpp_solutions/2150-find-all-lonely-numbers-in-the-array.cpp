#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findLonely(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<int> lonely;
        for (int num : nums) {
            if (count[num] == 1 && count.find(num - 1) == count.end() && count.find(num + 1) == count.end()) {
                lonely.push_back(num);
            }
        }

        return lonely;
    }
};