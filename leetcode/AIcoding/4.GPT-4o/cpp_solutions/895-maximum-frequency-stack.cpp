#include <unordered_map>
#include <vector>
#include <stack>
#include <algorithm>

class FreqStack {
public:
    FreqStack() {}

    void push(int val) {
        int freq = ++count[val];
        if (freq > maxFreq) {
            maxFreq = freq;
        }
        freqStack[freq].push(val);
    }

    int pop() {
        int val = freqStack[maxFreq].top();
        freqStack[maxFreq].pop();
        count[val]--;
        if (freqStack[maxFreq].empty()) {
            maxFreq--;
        }
        return val;
    }

private:
    int maxFreq = 0;
    std::unordered_map<int, int> count;
    std::unordered_map<int, std::stack<int>> freqStack;
};