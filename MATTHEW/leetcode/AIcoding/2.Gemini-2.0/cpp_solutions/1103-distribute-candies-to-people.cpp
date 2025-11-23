#include <vector>

using namespace std;

class Solution {
public:
    vector<int> distributeCandies(int candies, int num_people) {
        vector<int> result(num_people, 0);
        int i = 0;
        int give = 1;
        while (candies > 0) {
            if (candies >= give) {
                result[i % num_people] += give;
                candies -= give;
                give++;
            } else {
                result[i % num_people] += candies;
                candies = 0;
            }
            i++;
        }
        return result;
    }
};