class Solution {
public:
    int maxCandies(vector<int>& status, vector<int>& candies, vector<vector<int>>& keys, vector<vector<int>>& containedBoxes) {
        int n = status.size();
        vector<bool> haveKey(n, false);
        vector<bool> openedBox(n, false);
        queue<int> q;
        int totalCandies = 0;

        for (int i = 0; i < n; ++i) {
            if (status[i] == 1) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int currentBox = q.front();
            q.pop();

            if (openedBox[currentBox]) continue;
            openedBox[currentBox] = true;
            totalCandies += candies[currentBox];

            for (int key : keys[currentBox]) {
                haveKey[key] = true;
                if (status[key] == 1 && !openedBox[key]) {
                    q.push(key);
                }
            }

            for (int box : containedBoxes[currentBox]) {
                if (openedBox[box]) continue;
                if (haveKey[box] || status[box] == 1) {
                    q.push(box);
                }
            }
        }

        return totalCandies;
    }
};