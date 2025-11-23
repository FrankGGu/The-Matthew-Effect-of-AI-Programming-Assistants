#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numRabbits(vector<int>& answers) {
        unordered_map<int, int> count;
        for (int answer : answers) {
            count[answer]++;
        }

        int result = 0;
        for (auto const& [key, val] : count) {
            int groupSize = key + 1;
            int numGroups = (val + groupSize - 1) / groupSize;
            result += numGroups * groupSize;
        }

        return result;
    }
};