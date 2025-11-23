using namespace std;

class Solution {
public:
    int halveArray(vector<int>& nums) {
        double total = accumulate(nums.begin(), nums.end(), 0.0);
        double target = total / 2.0;
        double reduced = 0.0;
        int count = 0;

        priority_queue<double> pq;
        for (int num : nums) {
            pq.push(static_cast<double>(num));
        }

        while (reduced < target) {
            double max_val = pq.top();
            pq.pop();
            double half_val = max_val / 2.0;
            reduced += half_val;
            pq.push(half_val);
            count++;
        }

        return count;
    }
};