class SORTracker {
public:
    struct Location {
        string name;
        int score;
        bool operator<(const Location& other) const {
            return score == other.score ? name > other.name : score < other.score;
        }
    };

    priority_queue<Location> maxHeap;
    priority_queue<Location, vector<Location>, greater<Location>> minHeap;
    int queryCount;

    SORTracker() {
        queryCount = 0;
    }

    void add(string name, int score) {
        Location loc{name, score};
        if (!minHeap.empty() && loc < minHeap.top()) {
            maxHeap.push(loc);
        } else {
            minHeap.push(loc);
        }

        while (maxHeap.size() > queryCount) {
            minHeap.push(maxHeap.top());
            maxHeap.pop();
        }
    }

    string get() {
        string res = minHeap.top().name;
        maxHeap.push(minHeap.top());
        minHeap.pop();
        queryCount++;
        return res;
    }
};