#include <iostream>
#include <vector>
#include <set>
#include <map>

using namespace std;

class Solution {
public:
    int n;
    set<int> seats;

    Solution(int n) {
        this->n = n;
    }

    int seat() {
        if (seats.empty()) {
            seats.insert(0);
            return 0;
        }

        int prev = -1;
        int maxDist = 0;
        int res = 0;

        for (int seat : seats) {
            if (prev == -1) {
                if (seat > 0) {
                    maxDist = seat;
                    res = 0;
                }
            } else {
                int dist = (seat - prev) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                    res = prev + dist;
                }
            }
            prev = seat;
        }

        if (n - 1 - prev > maxDist) {
            res = n - 1;
        }

        seats.insert(res);
        return res;
    }

    void leave(int p) {
        seats.erase(p);
    }
};