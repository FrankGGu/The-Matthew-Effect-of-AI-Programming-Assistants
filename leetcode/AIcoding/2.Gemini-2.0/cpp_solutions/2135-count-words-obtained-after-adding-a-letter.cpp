#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int wordCount(vector<string>& startWords, vector<string>& targetWords) {
        unordered_set<int> startWordMasks;
        for (const string& word : startWords) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            startWordMasks.insert(mask);
        }

        int count = 0;
        for (const string& word : targetWords) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }

            for (char c : word) {
                int tempMask = mask ^ (1 << (c - 'a'));
                if (startWordMasks.count(tempMask)) {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
};