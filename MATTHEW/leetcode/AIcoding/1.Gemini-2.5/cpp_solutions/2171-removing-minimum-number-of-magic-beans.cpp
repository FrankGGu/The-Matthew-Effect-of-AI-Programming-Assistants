#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long removeBeans(std::vector<int>& beans) {
        std::sort(beans.begin(), beans.end());

        long long total_sum = 0;
        for (int bean_count : beans) {
            total_sum += bean_count;
        }

        long long min_removed_beans = total_sum; 
        int n = beans.size();

        for (int i = 0; i < n; ++i) {
            // If we choose beans[i] as the target number of beans for all kept bags:
            // All bags with fewer than beans[i] beans (beans[0]...beans[i-1]) must be emptied.
            // All bags with beans[i] or more beans (beans[i]...beans[n-1]) can be kept
            // and their bean counts reduced to beans[i].
            // The number of bags kept will be (n - i).

            long long beans_kept_for_this_choice = (long long)(n - i) * beans[i];
            long long removed_beans_for_this_choice = total_sum - beans_kept_for_this_choice;

            if (removed_beans_for_this_choice < min_removed_beans) {
                min_removed_beans = removed_beans_for_this_choice;
            }
        }

        return min_removed_beans;
    }
};