#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
private:
    unordered_map<int, int> freq;
    vector<stack<int>> groups;
    int maxFreq;

public:
    Solution() : maxFreq(0) {}

    void push(int val) {
        freq[val]++;
        int currentFreq = freq[val];
        if (currentFreq > maxFreq) {
            maxFreq = currentFreq;
            groups.resize(maxFreq);
        }
        groups[currentFreq - 1].push(val);
    }

    int pop() {
        int val = groups[maxFreq - 1].top();
        groups[maxFreq - 1].pop();
        freq[val]--;
        if (groups[maxFreq - 1].empty()) {
            maxFreq--;
        }
        return val;
    }
};