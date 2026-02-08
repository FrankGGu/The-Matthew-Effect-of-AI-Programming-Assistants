#include <iostream>
#include <vector>
#include <set>

using namespace std;

class Solution {
private:
    set<int> s;
public:
    Solution() {
        for (int i = 1; i <= 1000; ++i) {
            s.insert(i);
        }
    }

    int popSmallest() {
        int val = *s.begin();
        s.erase(s.begin());
        return val;
    }

    void addBack(int num) {
        if (s.find(num) == s.end()) {
            s.insert(num);
        }
    }
};