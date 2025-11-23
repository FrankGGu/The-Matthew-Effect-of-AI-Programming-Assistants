#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maxCandies(vector<int>& candies, vector<vector<int>>& boxes, vector<int>& keys, vector<int>& containedBoxes, vector<int>& initialBoxes) {
        unordered_map<int, vector<int>> boxKeys;
        unordered_map<int, vector<int>> boxContents;
        unordered_set<int> availableBoxes;
        unordered_set<int> collectedKeys;
        queue<int> q;

        for (int i = 0; i < boxes.size(); ++i) {
            boxKeys[i] = keys[i];
            boxContents[i] = containedBoxes[i];
        }

        for (int box : initialBoxes) {
            availableBoxes.insert(box);
        }

        while (!availableBoxes.empty()) {
            int currentBox = *availableBoxes.begin();
            availableBoxes.erase(currentBox);

            for (int key : boxKeys[currentBox]) {
                collectedKeys.insert(key);
            }

            for (int box : boxContents[currentBox]) {
                if (availableBoxes.find(box) == availableBoxes.end()) {
                    availableBoxes.insert(box);
                    q.push(box);
                }
            }

            if (collectedKeys.find(currentBox) != collectedKeys.end()) {
                int count = candies[currentBox];
                return count + maxCandies(candies, boxes, keys, containedBoxes, q.empty() ? vector<int>() : vector<int>{q.front()});
            } else {
                q.push(currentBox);
            }
        }

        return 0;
    }
};