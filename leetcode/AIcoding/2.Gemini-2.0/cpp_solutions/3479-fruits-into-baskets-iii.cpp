#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int totalFruit(vector<int>& fruits) {
        int max_fruits = 0;
        int window_start = 0;
        unordered_map<int, int> fruit_frequency;

        for (int window_end = 0; window_end < fruits.size(); window_end++) {
            fruit_frequency[fruits[window_end]]++;

            while (fruit_frequency.size() > 2) {
                fruit_frequency[fruits[window_start]]--;
                if (fruit_frequency[fruits[window_start]] == 0) {
                    fruit_frequency.erase(fruits[window_start]);
                }
                window_start++;
            }

            max_fruits = max(max_fruits, window_end - window_start + 1);
        }

        return max_fruits;
    }
};