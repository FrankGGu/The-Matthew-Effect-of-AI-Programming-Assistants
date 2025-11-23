#include <unordered_map>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numJewelsInStones(string jewels, string stones) {
        unordered_map<char, int> jewelMap;
        for (char j : jewels) {
            jewelMap[j]++;
        }
        int count = 0;
        for (char s : stones) {
            if (jewelMap.find(s) != jewelMap.end()) {
                count++;
            }
        }
        return count;
    }
};