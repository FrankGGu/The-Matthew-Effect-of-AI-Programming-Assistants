class Solution {
public:
    int eatenApples(vector<int>& apples, vector<int>& days) {
        int n = apples.size();
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        int res = 0;
        int i = 0;
        while (i < n || !pq.empty()) {
            if (i < n && apples[i] > 0) {
                pq.push({i + days[i], apples[i]});
            }
            while (!pq.empty() && pq.top().first <= i) {
                pq.pop();
            }
            if (!pq.empty()) {
                auto top = pq.top();
                pq.pop();
                if (top.second > 1) {
                    pq.push({top.first, top.second - 1});
                }
                res++;
            }
            i++;
        }
        return res;
    }
};