class Solution {
public:
    vector<int> distributeCandies(int candies, int num_people) {
        vector<int> result(num_people, 0);
        int current = 1;
        int index = 0;
        while (candies > 0) {
            int give = min(current, candies);
            result[index] += give;
            candies -= give;
            current++;
            index = (index + 1) % num_people;
        }
        return result;
    }
};