#include <stack>
#include <unordered_map>

using namespace std;

class FreqStack {
public:
    FreqStack() {
        maxFreq = 0;
    }

    void push(int val) {
        freq[val]++;
        maxFreq = max(maxFreq, freq[val]);
        group[freq[val]].push(val);
    }

    int pop() {
        int val = group[maxFreq].top();
        group[maxFreq].pop();
        freq[val]--;

        if (group[maxFreq].empty()) {
            maxFreq--;
        }

        return val;
    }

private:
    unordered_map<int, int> freq;
    unordered_map<int, stack<int>> group;
    int maxFreq;
};