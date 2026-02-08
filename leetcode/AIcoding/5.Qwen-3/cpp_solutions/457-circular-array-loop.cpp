#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isCircularLoop(vector<int>& nums) {
        int n = nums.size();
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (visited[i]) continue;
            unordered_set<int> set;
            int current = i;
            bool direction = nums[i] > 0;
            while (true) {
                if (visited[current]) {
                    if (set.find(current) != set.end()) {
                        return true;
                    } else {
                        break;
                    }
                }
                if ((nums[current] > 0) != direction) {
                    break;
                }
                visited[current] = true;
                set.insert(current);
                current = (current + nums[current] + n) % n;
            }
        }
        return false;
    }
};