#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> atmMachine(vector<int>& banknotes, int amount) {
        vector<int> result(5, 0);
        map<int, int> notes = {{20, 0}, {50, 0}, {100, 0}, {200, 0}, {500, 0}};
        for (int i = 0; i < 5; ++i) {
            notes[20 * pow(10, i)] = banknotes[i];
        }

        for (auto it = notes.rbegin(); it != notes.rend(); ++it) {
            int note = it->first;
            int count = min(amount / note, it->second);
            result[4 - (log(note) / log(10))] = count;
            amount -= count * note;
        }

        if (amount > 0) {
            return {-1};
        }

        return result;
    }
};