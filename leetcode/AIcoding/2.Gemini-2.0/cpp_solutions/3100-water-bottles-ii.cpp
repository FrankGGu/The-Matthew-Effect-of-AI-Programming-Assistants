#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

struct State {
    int a, b, c;
    State(int x, int y, int z) : a(x), b(y), c(z) {}
    bool operator==(const State& other) const {
        return a == other.a && b == other.b && c == other.c;
    }
};

namespace std {
    template <>
    struct hash<State> {
        size_t operator()(const State& s) const {
            return ((hash<int>()(s.a) ^ (hash<int>()(s.b) << 1)) >> 1) ^ (hash<int>()(s.c) << 1);
        }
    };
}

class Solution {
public:
    int solve(int a, int b, int c, int d, vector<vector<int>>& operations) {
        queue<State> q;
        unordered_set<State> visited;

        q.push(State(a, b, c));
        visited.insert(State(a, b, c));

        while (!q.empty()) {
            State curr = q.front();
            q.pop();

            if (curr.a == d || curr.b == d || curr.c == d) {
                return 1;
            }

            for (auto& op : operations) {
                int x = op[0];
                int y = op[1];
                int z = op[2];

                int nextA = curr.a, nextB = curr.b, nextC = curr.c;

                if (x == 0) {
                    nextA = 0;
                } else if (x == 1) {
                    nextA = a;
                } else if (x == 2) {
                    int transfer = min(curr.a, b - curr.b);
                    nextA = curr.a - transfer;
                    nextB = curr.b + transfer;
                } else {
                    int transfer = min(curr.a, c - curr.c);
                    nextA = curr.a - transfer;
                    nextC = curr.c + transfer;
                }

                if (y == 0) {
                    nextB = 0;
                } else if (y == 1) {
                    nextB = b;
                } else if (y == 2) {
                    int transfer = min(curr.b, a - curr.a);
                    nextB = curr.b - transfer;
                    nextA = curr.a + transfer;
                } else {
                    int transfer = min(curr.b, c - curr.c);
                    nextB = curr.b - transfer;
                    nextC = curr.c + transfer;
                }

                if (z == 0) {
                    nextC = 0;
                } else if (z == 1) {
                    nextC = c;
                } else if (z == 2) {
                    int transfer = min(curr.c, a - curr.a);
                    nextC = curr.c - transfer;
                    nextA = curr.a + transfer;
                } else {
                    int transfer = min(curr.c, b - curr.b);
                    nextC = curr.c - transfer;
                    nextB = curr.b + transfer;
                }

                State nextState(nextA, nextB, nextC);
                if (visited.find(nextState) == visited.end()) {
                    visited.insert(nextState);
                    q.push(nextState);
                }
            }
        }

        return 0;
    }
};