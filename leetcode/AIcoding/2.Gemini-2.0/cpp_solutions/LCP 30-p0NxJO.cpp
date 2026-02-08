#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int magicTower(vector<int>& nums) {
        long long sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum < 0) {
            return -1;
        }

        priority_queue<int> pq;
        long long health = 1;
        int steps = 0;
        for (int num : nums) {
            health += num;
            if (num < 0) {
                pq.push(-num);
            }
            while (health <= 0) {
                health += pq.top();
                pq.pop();
                steps++;
            }
        }

        return steps;
    }
};