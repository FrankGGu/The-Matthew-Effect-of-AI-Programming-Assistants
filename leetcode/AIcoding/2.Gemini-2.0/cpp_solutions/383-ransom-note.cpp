#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canConstruct(string ransomNote, string magazine) {
        unordered_map<char, int> magazineCount;
        for (char c : magazine) {
            magazineCount[c]++;
        }

        for (char c : ransomNote) {
            if (magazineCount.find(c) == magazineCount.end() || magazineCount[c] == 0) {
                return false;
            }
            magazineCount[c]--;
        }

        return true;
    }
};