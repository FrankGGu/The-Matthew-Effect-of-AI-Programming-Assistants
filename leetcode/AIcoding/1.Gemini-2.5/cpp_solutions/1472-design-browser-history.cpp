#include <vector>
#include <string>
#include <algorithm>

class BrowserHistory {
private:
    std::vector<std::string> history;
    int current_index;
    int max_index;

public:
    BrowserHistory(std::string homepage) {
        history.push_back(homepage);
        current_index = 0;
        max_index = 0;
    }

    void visit(std::string url) {
        current_index++;
        if (current_index < history.size()) {
            history[current_index] = url;
        } else {
            history.push_back(url);
        }
        max_index = current_index;
    }

    std::string back(int steps) {
        current_index = std::max(0, current_index - steps);
        return history[current_index];
    }

    std::string forward(int steps) {
        current_index = std::min(max_index, current_index + steps);
        return history[current_index];
    }
};