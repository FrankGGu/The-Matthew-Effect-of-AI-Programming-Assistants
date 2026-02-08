#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long numberOfWeeks(vector<int>& milestones) {
        long long sum = 0;
        for (int m : milestones) {
            sum += m;
        }
        sort(milestones.begin(), milestones.end());
        int n = milestones.size();
        long long res = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (milestones[i] < res + 1) {
                res += milestones[i] + 1;
            } else {
                return sum;
            }
        }
        return res + milestones[n - 1];
    }
};