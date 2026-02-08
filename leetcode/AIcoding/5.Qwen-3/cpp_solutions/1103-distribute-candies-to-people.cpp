#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> distributeCandies(int candies, int num_people) {
        vector<int> result(num_people, 0);
        int i = 0;
        int give = 1;
        while (candies > 0) {
            if (i >= num_people) {
                i = 0;
            }
            if (give <= candies) {
                result[i] += give;
                candies -= give;
                give++;
            } else {
                result[i] += candies;
                candies = 0;
            }
            i++;
        }
        return result;
    }
};