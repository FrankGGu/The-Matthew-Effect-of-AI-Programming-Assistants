#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maxCandies(vector<int>& status, vector<int>& candies, vector<vector<int>>& keys, vector<vector<int>>& containedBoxes, vector<int>& initialBoxes) {
        int n = status.size();
        vector<bool> hasBox(n, false);
        queue<int> q;
        int ans = 0;

        for (int box : initialBoxes) {
            hasBox[box] = true;
            q.push(box);
        }

        while (!q.empty()) {
            int box = q.front();
            q.pop();

            if (status[box] == 1) {
                ans += candies[box];
                candies[box] = 0;

                for (int key : keys[box]) {
                    if (status[key] == 0) {
                        status[key] = 1;
                        for (int i = 0; i < n; ++i) {
                            if (hasBox[i] && status[i] == 1 && candies[i] > 0) {
                                q.push(i);
                            }
                        }
                    }
                }

                for (int containedBox : containedBoxes[box]) {
                    if (!hasBox[containedBox]) {
                        hasBox[containedBox] = true;
                        q.push(containedBox);
                    }
                }
            } else {
                bool canOpen = false;
                for (int i = 0; i < n; ++i) {
                    if (status[i] == 1 && candies[i] == 0) {
                         for(int key : keys[i]){
                             if(key == box){
                                 canOpen = true;
                                 break;
                             }
                         }
                    }
                    if(canOpen) break;
                }
                if(!canOpen)
                    q.push(box);
            }

            bool allOpened = true;
            for(int i = 0; i < n; ++i){
                if(hasBox[i] && status[i] == 0){
                    bool canOpen = false;
                    for (int j = 0; j < n; ++j) {
                        if (status[j] == 1 && candies[j] == 0) {
                             for(int key : keys[j]){
                                 if(key == i){
                                     canOpen = true;
                                     break;
                                 }
                             }
                        }
                        if(canOpen) break;
                    }
                    if(!canOpen)
                        allOpened = false;
                }
            }
            if(q.size() == 1 && !allOpened && q.front() == box && status[box] == 0)
                break;
            if(q.size() > n)
                break;
        }

        return ans;
    }
};