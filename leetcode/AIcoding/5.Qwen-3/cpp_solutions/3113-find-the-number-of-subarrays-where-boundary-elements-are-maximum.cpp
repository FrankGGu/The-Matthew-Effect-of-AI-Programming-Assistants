#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int numSubarraysWithMaxOnBoundaries(int* arr, int n) {
        int count = 0;
        stack<int> s;
        for (int i = 0; i < n; ++i) {
            while (!s.empty() && arr[s.top()] <= arr[i]) {
                s.pop();
            }
            if (!s.empty()) {
                count += i - s.top();
            }
            s.push(i);
        }
        return count;
    }
};