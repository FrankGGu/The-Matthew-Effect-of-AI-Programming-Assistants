class BrowserHistory {
public:
    list<string> history;
    list<string>::iterator current;

    BrowserHistory(string homepage) {
        history.push_back(homepage);
        current = history.begin();
    }

    void visit(string url) {
        auto next = next(current);
        history.erase(next, history.end());
        history.push_back(url);
        current = prev(history.end());
    }

    string back(int steps) {
        while (steps-- > 0 && current != history.begin()) {
            --current;
        }
        return *current;
    }

    string forward(int steps) {
        while (steps-- > 0 && next(current) != history.end()) {
            ++current;
        }
        return *current;
    }
};