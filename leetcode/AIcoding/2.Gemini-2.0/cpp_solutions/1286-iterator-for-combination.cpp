#include <string>
#include <vector>

using namespace std;

class CombinationIterator {
public:
    CombinationIterator(string characters, int combinationLength) {
        s = characters;
        len = combinationLength;
        generateCombinations(0, "", 0);
        index = 0;
    }

    string next() {
        return combinations[index++];
    }

    bool hasNext() {
        return index < combinations.size();
    }

private:
    string s;
    int len;
    vector<string> combinations;
    int index;

    void generateCombinations(int start, string current, int currentLen) {
        if (currentLen == len) {
            combinations.push_back(current);
            return;
        }

        for (int i = start; i < s.length(); ++i) {
            generateCombinations(i + 1, current + s[i], currentLen + 1);
        }
    }
};