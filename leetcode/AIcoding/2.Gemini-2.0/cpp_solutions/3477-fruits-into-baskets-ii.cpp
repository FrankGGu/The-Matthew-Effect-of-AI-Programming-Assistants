#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int totalFruit(vector<int>& fruits) {
        int n = fruits.size();
        int max_fruits = 0;
        int start = 0;
        unordered_map<int, int> fruit_count;

        for (int end = 0; end < n; ++end) {
            fruit_count[fruits[end]]++;

            while (fruit_count.size() > 2) {
                fruit_count[fruits[start]]--;
                if (fruit_count[fruits[start]] == 0) {
                    fruit_count.erase(fruits[start]);
                }
                start++;
            }

            max_fruits = max(max_fruits, end - start + 1);
        }

        return max_fruits;
    }
};