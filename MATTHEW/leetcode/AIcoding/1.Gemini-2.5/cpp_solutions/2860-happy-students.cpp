#include <vector>
#include <algorithm>

class Solution {
public:
    int happyStudents(std::vector<int>& satisfaction) {
        std::sort(satisfaction.begin(), satisfaction.end());
        int n = satisfaction.size();
        int count = 0;

        // Case k = 0: No students are called.
        // All n students are not called.
        // Condition: For all students i, satisfaction[i] >= 0.
        // This is always true as satisfaction values are non-negative.
        count = 1;

        // Cases for k students called, where 1 <= k < n:
        // The first k students (satisfaction[0]...satisfaction[k-1]) are called.
        // The remaining n-k students (satisfaction[k]...satisfaction[n-1]) are not called.
        for (int k = 1; k < n; ++k) {
            // Condition for called students to be happy:
            // All satisfaction[i] for i in [0, k-1] must be less than k.
            // Since the array is sorted, it's sufficient to check satisfaction[k-1] < k.
            bool called_students_happy = (satisfaction[k-1] < k);

            // Condition for not-called students to be happy:
            // All satisfaction[j] for j in [k, n-1] must be greater than or equal to k.
            // Since the array is sorted, it's sufficient to check satisfaction[k] >= k.
            bool not_called_students_happy = (satisfaction[k] >= k);

            if (called_students_happy && not_called_students_happy) {
                count++;
            }
        }

        // Case k = n: All n students are called.
        // Condition: All satisfaction[i] for i in [0, n-1] must be less than n.
        // Since the array is sorted, it's sufficient to check satisfaction[n-1] < n.
        if (satisfaction[n-1] < n) {
            count++;
        }

        return count;
    }
};