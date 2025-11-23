#include <queue>

class RecentCounter {
private:
    std::queue<int> requests;

public:
    RecentCounter() {
    }

    int ping(int t) {
        requests.push(t);
        while (requests.front() < t - 3000) {
            requests.pop();
        }
        return requests.size();
    }
};