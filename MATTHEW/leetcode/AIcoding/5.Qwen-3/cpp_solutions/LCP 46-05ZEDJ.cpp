#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minOperations(int n, vector<int>& b) {
        vector<int> v(n);
        for (int i = 0; i < n; ++i) {
            v[i] = i + 1;
        }
        queue<int> q;
        for (int num : b) {
            q.push(num);
        }
        int operations = 0;
        for (int i = 0; i < n; ++i) {
            if (v[i] == q.front()) {
                q.pop();
            } else {
                ++operations;
                q.push(q.front());
                q.pop();
            }
        }
        return operations;
    }
};