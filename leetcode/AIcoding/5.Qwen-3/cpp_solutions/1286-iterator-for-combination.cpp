#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
private:
    vector<int> combinations;
    int size;
    int index;

public:
    Solution(string characters, int combinationLength) {
        size = combinationLength;
        index = 0;
        for (int i = 0; i < combinationLength; ++i) {
            combinations.push_back(i);
        }
    }

    string next() {
        string result;
        for (int i : combinations) {
            result += to_string(i);
        }
        int i = size - 1;
        while (i >= 0 && combinations[i] == (int)(combinations.size() - size + i)) {
            --i;
        }
        if (i >= 0) {
            ++combinations[i];
            for (int j = i + 1; j < size; ++j) {
                combinations[j] = combinations[j - 1] + 1;
            }
        }
        return result;
    }

    bool hasNext() {
        return index < (1 << combinations.size()) - 1;
    }
};