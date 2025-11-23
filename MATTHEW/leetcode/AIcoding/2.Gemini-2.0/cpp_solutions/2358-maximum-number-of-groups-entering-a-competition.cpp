#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumGroups(vector<int>& grades) {
        sort(grades.begin(), grades.end());
        int count = 0;
        int sum = 0;
        int num = 0;
        for (int i = 0; i < grades.size(); ++i) {
            sum += grades[i];
            num++;
            if (sum >= (count + 1) * (count + 2) / 2) {
                count++;
            }
        }
        return count;
    }
};