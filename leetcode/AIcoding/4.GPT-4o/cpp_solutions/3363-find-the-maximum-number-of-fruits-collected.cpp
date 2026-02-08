class Solution {
public:
    int maxFruits(vector<int>& fruits, int k) {
        int n = fruits.size();
        int left = 0, right = 0;
        int count = 0;
        unordered_map<int, int> fruitCount;

        while (right < n) {
            fruitCount[fruits[right]]++;
            while (fruitCount.size() > k) {
                fruitCount[fruits[left]]--;
                if (fruitCount[fruits[left]] == 0) {
                    fruitCount.erase(fruits[left]);
                }
                left++;
            }
            count = max(count, right - left + 1);
            right++;
        }

        return count;
    }
};