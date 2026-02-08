#include <vector>
#include <set>
#include <cmath>

class Solution {
public:
    bool validSquare(std::vector<int>& p1, std::vector<int>& p2, std::vector<int>& p3, std::vector<int>& p4) {
        std::set<int> dists;
        auto dist = [](std::vector<int>& a, std::vector<int>& b) {
            return (a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1]);
        };

        dists.insert(dist(p1, p2));
        dists.insert(dist(p1, p3));
        dists.insert(dist(p1, p4));
        dists.insert(dist(p2, p3));
        dists.insert(dist(p2, p4));
        dists.insert(dist(p3, p4));

        return !dists.count(0) && dists.size() == 2;
    }
};