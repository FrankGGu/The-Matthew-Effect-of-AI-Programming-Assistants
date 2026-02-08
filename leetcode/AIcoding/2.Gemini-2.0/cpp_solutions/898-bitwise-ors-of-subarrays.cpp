#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int subarrayBitwiseORs(vector<int>& arr) {
        unordered_set<int> result;
        unordered_set<int> current;

        for (int num : arr) {
            unordered_set<int> next;
            next.insert(num);
            for (int prev : current) {
                next.insert(prev | num);
            }
            current = next;
            for (int val : current) {
                result.insert(val);
            }
        }

        return result.size();
    }
};