#include <vector>

using namespace std;

class Solution {
public:
    int adventureCamp(vector<vector<int>>& expeditions) {
        vector<int> firstCamp(expeditions[0].begin(), expeditions[0].end());
        vector<bool> present(1001, false);
        for (int camp : firstCamp) {
            present[camp] = true;
        }

        int uniqueCamps = 0;
        for (int i = 1; i <= 1000; ++i) {
            if (present[i]) {
                uniqueCamps++;
            }
        }

        int maxNewCamps = 0;
        int currentNewCamps = 0;

        for (int i = 1; i < expeditions.size(); ++i) {
            currentNewCamps = 0;
            for (int camp : expeditions[i]) {
                if (!present[camp]) {
                    present[camp] = true;
                    currentNewCamps++;
                }
            }
            maxNewCamps = max(maxNewCamps, currentNewCamps);
        }

        if (maxNewCamps == 0) {
            return -1;
        }

        int day = 0;
        present.assign(1001, false);
        for (int camp : firstCamp) {
            present[camp] = true;
        }
        for (int i = 1; i < expeditions.size(); ++i) {
            int newCamps = 0;
            for (int camp : expeditions[i]) {
                if (!present[camp]) {
                    present[camp] = true;
                    newCamps++;
                }
            }
            if (newCamps == maxNewCamps) {
                day = i;
                break;
            }
        }

        return day;
    }
};