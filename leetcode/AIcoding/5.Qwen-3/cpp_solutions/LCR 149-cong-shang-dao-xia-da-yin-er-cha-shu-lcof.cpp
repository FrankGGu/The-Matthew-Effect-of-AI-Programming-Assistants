#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int decorateRecord(vector<int>& root) {
        if (root.empty()) return 0;

        int count = 0;
        queue<int> q;
        q.push(root[0]);

        int index = 1;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int node = q.front();
                q.pop();
                ++count;
                if (index < root.size() && root[index] != -1) {
                    q.push(root[index]);
                }
                ++index;
                if (index < root.size() && root[index] != -1) {
                    q.push(root[index]);
                }
                ++index;
            }
        }

        return count;
    }
};