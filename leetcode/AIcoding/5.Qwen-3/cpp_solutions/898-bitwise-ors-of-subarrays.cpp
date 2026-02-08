#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int subarrayBitwiseORSums(vector<int>& A) {
        vector<unordered_set<int>> dp;
        unordered_set<int> prev;
        for (int num : A) {
            unordered_set<int> curr;
            curr.insert(num);
            for (int x : prev) {
                curr.insert(x | num);
            }
            dp.push_back(curr);
            prev = curr;
        }
        int result = 0;
        for (const auto& s : dp) {
            result += s.size();
        }
        return result;
    }
};