class Solution {
public:
    int maxCandies(vector<int>& status, vector<int>& candies, vector<vector<int>>& keys, vector<vector<int>>& containedBoxes, vector<int>& initialBoxes) {
        int n = status.size();
        vector<bool> hasBox(n, false);
        vector<bool> hasKey(n, false);
        vector<bool> opened(n, false);
        queue<int> q;

        for (int box : initialBoxes) {
            hasBox[box] = true;
            if (status[box] == 1) {
                q.push(box);
                opened[box] = true;
            }
        }

        int total = 0;
        while (!q.empty()) {
            int current = q.front();
            q.pop();
            total += candies[current];

            for (int key : keys[current]) {
                hasKey[key] = true;
                if (hasBox[key] && !opened[key]) {
                    q.push(key);
                    opened[key] = true;
                }
            }

            for (int box : containedBoxes[current]) {
                hasBox[box] = true;
                if ((status[box] == 1 || hasKey[box]) && !opened[box]) {
                    q.push(box);
                    opened[box] = true;
                }
            }
        }

        return total;
    }
};