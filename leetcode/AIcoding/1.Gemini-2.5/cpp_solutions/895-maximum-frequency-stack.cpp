#include <unordered_map>
#include <stack>
#include <algorithm> // For std::max

class FreqStack {
public:
    std::unordered_map<int, int> freq;
    std::unordered_map<int, std::stack<int>> group;
    int maxFreq;

    FreqStack() {
        maxFreq = 0;
    }

    void push(int val) {
        freq[val]++;
        maxFreq = std::max(maxFreq, freq[val]);
        group[freq[val]].push(val);
    }

    int pop() {
        int topVal = group[maxFreq].top();
        group[maxFreq].pop();
        freq[topVal]--;

        if (group[maxFreq].empty()) {
            maxFreq--;
        }
        return topVal;
    }
};