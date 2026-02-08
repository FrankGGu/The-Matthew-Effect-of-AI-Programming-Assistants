#include <queue>

class RecentCounter {
public:
    RecentCounter() {}

    int ping(int t) {
        q.push(t);
        while (q.front() < t - 3000) {
            q.pop();
        }
        return q.size();
    }

private:
    std::queue<int> q;
};