#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        set<int> s;
        for (int num : nums) {
            if (num > 0) {
                s.insert(num);
            }
        }
        return s.size();
    }
};