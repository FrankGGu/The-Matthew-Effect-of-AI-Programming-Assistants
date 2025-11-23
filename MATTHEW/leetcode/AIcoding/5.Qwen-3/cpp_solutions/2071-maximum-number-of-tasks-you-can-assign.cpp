#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxTasks(vector<int>& skill, vector<int>& assign, int limit) {
        sort(skill.begin(), skill.end());
        sort(assign.begin(), assign.end());

        int n = skill.size();
        int m = assign.size();

        int left = 0;
        int right = min(n, m);
        int result = 0;

        while (left <= right) {
            int mid = (left + right) / 2;
            bool possible = true;

            vector<int> used(m, false);
            int count = 0;
            int i = n - 1;
            int j = m - 1;

            for (int k = 0; k < mid; ++k) {
                if (i < 0 || j < 0) {
                    possible = false;
                    break;
                }

                if (skill[i] >= assign[j]) {
                    used[j] = true;
                    count++;
                    i--;
                    j--;
                } else {
                    int pos = j;
                    while (pos >= 0 && !used[pos] && assign[pos] < skill[i]) {
                        pos--;
                    }

                    if (pos < 0) {
                        possible = false;
                        break;
                    }

                    used[pos] = true;
                    count++;
                    i--;
                    j--;
                }
            }

            if (possible && count == mid) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
};