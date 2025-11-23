#include <queue>

class RecentCounter {
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

private:
    std::queue<int> requests;
};