class Solution {
public:
    int magicTower(vector<int>& nums) {
        priority_queue<int> pq;
        long long sum = 1;
        long long hp = 1;
        int res = 0;
        for (int num : nums) {
            sum += num;
            hp += num;
            if (num < 0) {
                pq.push(-num);
            }
            while (hp <= 0 && !pq.empty()) {
                int top = pq.top();
                pq.pop();
                hp += top;
                res++;
            }
            if (hp <= 0) {
                return -1;
            }
        }
        return sum > 0 ? res : -1;
    }
};