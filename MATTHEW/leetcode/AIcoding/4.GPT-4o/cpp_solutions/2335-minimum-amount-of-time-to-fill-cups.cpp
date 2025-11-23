class Solution {
public:
    int fillCups(vector<int>& cups) {
        priority_queue<int> pq(cups.begin(), cups.end());
        int time = 0;

        while (!pq.empty()) {
            int first = pq.top();
            pq.pop();
            if (pq.empty() && first == 0) break;
            if (first > 0) {
                first--;
                time++;
            }
            if (!pq.empty()) {
                int second = pq.top();
                pq.pop();
                if (second > 0) {
                    second--;
                    pq.push(second);
                }
                pq.push(first);
            } else {
                pq.push(first);
            }
        }

        return time;
    }
};