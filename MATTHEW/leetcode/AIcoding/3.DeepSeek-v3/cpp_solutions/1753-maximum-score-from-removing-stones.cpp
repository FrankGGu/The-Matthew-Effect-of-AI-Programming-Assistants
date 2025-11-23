class Solution {
public:
    int maximumScore(int a, int b, int c) {
        priority_queue<int> pq;
        pq.push(a);
        pq.push(b);
        pq.push(c);
        int score = 0;
        while (true) {
            int x = pq.top(); pq.pop();
            int y = pq.top(); pq.pop();
            if (y == 0) break;
            pq.push(x - 1);
            pq.push(y - 1);
            score++;
        }
        return score;
    }
};