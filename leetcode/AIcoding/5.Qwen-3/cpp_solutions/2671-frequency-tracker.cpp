#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    void add(int number) {
        count[number]++;
    }

    void deleteOne(int number) {
        if (count.find(number) != count.end() && count[number] > 0) {
            count[number]--;
            if (count[number] == 0) {
                count.erase(number);
            }
        }
    }

    bool hasFrequency(int frequency) {
        for (const auto& pair : count) {
            if (pair.second == frequency) {
                return true;
            }
        }
        return false;
    }

private:
    unordered_map<int, int> count;
};