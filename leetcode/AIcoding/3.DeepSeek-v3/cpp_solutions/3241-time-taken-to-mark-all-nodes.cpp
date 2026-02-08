#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int timeTaken(vector<int>& arrival, vector<int>& state) {
        queue<int> enter, exit;
        unordered_map<int, unordered_set<int>> timeToIndices;
        int n = arrival.size();
        for (int i = 0; i < n; ++i) {
            timeToIndices[arrival[i]].insert(i);
        }

        int currentTime = 0;
        int lastUsed = -1; // -1: none, 0: exit, 1: enter
        int result = 0;
        vector<int> marked(n, -1);

        while (true) {
            if (enter.empty() && exit.empty() && timeToIndices.find(currentTime) == timeToIndices.end()) {
                bool allMarked = true;
                for (int i = 0; i < n; ++i) {
                    if (marked[i] == -1) {
                        allMarked = false;
                        break;
                    }
                }
                if (allMarked) break;
            }

            if (timeToIndices.find(currentTime) != timeToIndices.end()) {
                for (int idx : timeToIndices[currentTime]) {
                    if (state[idx] == 0) {
                        enter.push(idx);
                    } else {
                        exit.push(idx);
                    }
                }
                timeToIndices.erase(currentTime);
            }

            bool canExit = !exit.empty() && (lastUsed == -1 || lastUsed == 0 || enter.empty());
            bool canEnter = !enter.empty() && (lastUsed == -1 || lastUsed == 1 || exit.empty());

            if (canExit || canEnter) {
                if (canExit && (!canEnter || lastUsed == 0 || (lastUsed == -1 && exit.front() < enter.front()))) {
                    int idx = exit.front();
                    exit.pop();
                    marked[idx] = currentTime;
                    lastUsed = 0;
                } else {
                    int idx = enter.front();
                    enter.pop();
                    marked[idx] = currentTime;
                    lastUsed = 1;
                }
            } else {
                lastUsed = -1;
            }

            currentTime++;
        }

        int maxTime = 0;
        for (int time : marked) {
            if (time > maxTime) {
                maxTime = time;
            }
        }
        return maxTime + 1;
    }
};