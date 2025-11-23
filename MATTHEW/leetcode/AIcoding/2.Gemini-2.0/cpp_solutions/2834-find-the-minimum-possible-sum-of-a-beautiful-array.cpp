#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    long long minimumPossibleSum(int n, int target) {
        long long sum = 0;
        unordered_set<int> used;
        int current = 1;
        while (used.size() < n) {
            if (used.find(current) == used.end()) {
                if (used.find(target - current) == used.end()) {
                    sum += current;
                    used.insert(current);
                }
            }
            current++;
        }
        return sum;
    }
};