class BrowserHistory {
public:
    BrowserHistory(string homepage) {
        history.push_back(homepage);
        current = 0;
    }

    void visit(string url) {
        history.resize(current + 1);
        history.push_back(url);
        current++;
    }

    string back(int steps) {
        current = max(0, current - steps);
        return history[current];
    }

    string forward(int steps) {
        current = min((int)history.size() - 1, current + steps);
        return history[current];
    }

private:
    vector<string> history;
    int current;
};