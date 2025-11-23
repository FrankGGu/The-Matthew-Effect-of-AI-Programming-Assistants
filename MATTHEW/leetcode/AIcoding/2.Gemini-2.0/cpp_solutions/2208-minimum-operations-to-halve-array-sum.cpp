#include <vector>
#include <queue>
#include <numeric>

using namespace std;

class Solution {
public:
    int halveArray(vector<int>& nums) {
        priority_queue<double> pq;
        double sum = 0.0;
        for (int num : nums) {
            pq.push(num);
            sum += num;
        }

        double halved_sum = sum / 2.0;
        double current_sum = sum;
        int operations = 0;

        while (current_sum > halved_sum) {
            double top = pq.top();
            pq.pop();
            current_sum -= top / 2.0;
            pq.push(top / 2.0);
            operations++;
        }

        return operations;
    }
};