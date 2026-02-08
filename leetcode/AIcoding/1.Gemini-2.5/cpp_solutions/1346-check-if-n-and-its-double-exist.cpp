#include <vector>
#include <unordered_set>

class Solution {
public:
    bool checkIfExist(std::vector<int>& arr) {
        std::unordered_set<int> seen_numbers;
        for (int num : arr) {
            if (seen_numbers.count(num * 2)) {
                return true;
            }
            if (num % 2 == 0 && seen_numbers.count(num / 2)) {
                return true;
            }
            seen_numbers.insert(num);
        }
        return false;
    }
};