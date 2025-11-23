#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int smallestRepunitDivByK(int k) {
        if (k % 2 == 0 || k % 5 == 0) {
            return -1;
        }
        queue<int> q;
        q.push(1 % k);
        int length = 1;
        unordered_set<int> visited;
        visited.insert(1 % k);
        while (!q.empty()) {
            int remainder = q.front();
            q.pop();
            if (remainder == 0) {
                return length;
            }
            int next1 = (remainder * 10 + 1) % k;
            if (visited.find(next1) == visited.end()) {
                visited.insert(next1);
                q.push(next1);
                length++;
            }
            int next0 = (remainder * 10) % k;
            if (visited.find(next0) == visited.end()) {
                visited.insert(next0);
                q.push(next0);
                length++;
            }
        }
        return -1;
    }
};