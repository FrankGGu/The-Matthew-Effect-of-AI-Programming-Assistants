class Solution {
public:
    int eatenApples(vector<int>& apples, vector<int>& days) {
        int n = apples.size();
        priority_queue<pair<int, int>> pq;
        int result = 0;

        for (int i = 0; i < n || !pq.empty(); ++i) {
            if (i < n) {
                pq.push({apples[i], i + days[i]});
            }
            while (!pq.empty() && pq.top().second <= i) {
                pq.pop();
            }
            if (!pq.empty()) {
                result++;
                if (--pq.top().first == 0) {
                    pq.pop();
                }
            }
        }
        return result;
    }
};