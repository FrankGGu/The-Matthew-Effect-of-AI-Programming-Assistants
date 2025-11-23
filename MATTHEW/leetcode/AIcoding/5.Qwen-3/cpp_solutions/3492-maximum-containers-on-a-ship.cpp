#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxBoxesInContainer(vector<int>& container, vector<int>& box) {
        sort(container.begin(), container.end());
        sort(box.begin(), box.end());

        int i = 0, j = 0;
        int count = 0;

        while (i < container.size() && j < box.size()) {
            if (box[j] <= container[i]) {
                count++;
                j++;
            }
            i++;
        }

        return count;
    }
};