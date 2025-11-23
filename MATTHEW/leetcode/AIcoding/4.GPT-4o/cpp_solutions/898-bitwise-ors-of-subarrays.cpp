#include <vector>
#include <unordered_set>
using namespace std;

class Solution {
public:
    int subarrayBitwiseORs(vector<int>& A) {
        unordered_set<int> result, current;
        int prev = 0;
        for (int a : A) {
            unordered_set<int> next;
            next.insert(a);
            for (int b : current) {
                next.insert(a | b);
            }
            current = move(next);
            result.insert(current.begin(), current.end());
        }
        return result.size();
    }
};