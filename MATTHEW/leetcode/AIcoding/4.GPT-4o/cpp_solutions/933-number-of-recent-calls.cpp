class RecentCounter {
public:
    RecentCounter() {
    }

    int ping(int t) {
        calls.push(t);
        while (calls.front() < t - 3000) {
            calls.pop();
        }
        return calls.size();
    }

private:
    queue<int> calls;
};