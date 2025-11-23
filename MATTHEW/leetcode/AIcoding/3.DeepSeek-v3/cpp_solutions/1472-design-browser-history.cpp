class BrowserHistory {
private:
    vector<string> history;
    int current;
    int last;

public:
    BrowserHistory(string homepage) {
        history.push_back(homepage);
        current = 0;
        last = 0;
    }

    void visit(string url) {
        current++;
        if (current < history.size()) {
            history[current] = url;
        } else {
            history.push_back(url);
        }
        last = current;
    }

    string back(int steps) {
        current = max(0, current - steps);
        return history[current];
    }

    string forward(int steps) {
        current = min(last, current + steps);
        return history[current];
    }
};