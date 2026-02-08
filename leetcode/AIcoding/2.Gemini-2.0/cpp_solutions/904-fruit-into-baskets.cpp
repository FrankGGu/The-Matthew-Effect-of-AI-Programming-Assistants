#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int totalFruit(vector<int>& fruits) {
        int max_fruits = 0;
        int left = 0;
        unordered_map<int, int> fruit_count;

        for (int right = 0; right < fruits.size(); ++right) {
            fruit_count[fruits[right]]++;

            while (fruit_count.size() > 2) {
                fruit_count[fruits[left]]--;
                if (fruit_count[fruits[left]] == 0) {
                    fruit_count.erase(fruits[left]);
                }
                left++;
            }

            max_fruits = max(max_fruits, right - left + 1);
        }

        return max_fruits;
    }
};