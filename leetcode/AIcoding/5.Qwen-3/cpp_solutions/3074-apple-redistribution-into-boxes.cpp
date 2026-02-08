#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumBoxes(vector<int>& apple, vector<int>& capacity) {
        sort(apple.begin(), apple.end());
        sort(capacity.begin(), capacity.end());

        int boxes = 0;
        int i = apple.size() - 1;
        int j = capacity.size() - 1;

        while (i >= 0) {
            if (capacity[j] >= apple[i]) {
                boxes++;
                i--;
                j--;
            } else {
                boxes++;
                apple[i] -= capacity[j];
                j--;
            }
        }

        return boxes;
    }
};