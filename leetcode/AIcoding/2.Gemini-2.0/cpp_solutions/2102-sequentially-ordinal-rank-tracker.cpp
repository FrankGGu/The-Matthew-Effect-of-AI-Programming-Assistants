#include <set>

using namespace std;

class SORTracker {
public:
    set<pair<int, int>> s;
    int count;

    SORTracker() {
        count = 0;
    }

    void add(int score, int name) {
        s.insert({score, -name});
    }

    string get() {
        auto it = s.begin();
        advance(it, count);
        string res = to_string(it->first) + " " + to_string(-it->second);
        count++;
        return res;
    }
};