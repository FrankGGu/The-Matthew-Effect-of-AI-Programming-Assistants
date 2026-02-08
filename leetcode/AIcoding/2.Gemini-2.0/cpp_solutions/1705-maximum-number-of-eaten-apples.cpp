#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    int eatenApples(vector<int>& apples, vector<int>& days) {
        int n = apples.size();
        int eaten = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int i = 0; i < n || !pq.empty(); ++i) {
            while (!pq.empty() && pq.top().first <= i) {
                pq.pop();
            }

            if (i < n && apples[i] > 0) {
                pq.push({i + days[i], apples[i]});
            }

            if (!pq.empty()) {
                auto top = pq.top();
                pq.pop();
                top.second--;
                eaten++;
                if (top.second > 0 && top.first > i + 1) {
                    pq.push(top);
                }
            }
        }

        return eaten;
    }
};