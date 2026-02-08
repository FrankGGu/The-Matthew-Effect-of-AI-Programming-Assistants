#include <vector>
#include <numeric>

class Solution {
public:
    int countStudents(std::vector<int>& students, std::vector<int>& sandwiches) {
        int count0 = 0; // Number of students who want circular sandwiches (0)
        int count1 = 0; // Number of students who want square sandwiches (1)

        for (int student_pref : students) {
            if (student_pref == 0) {
                count0++;
            } else {
                count1++;
            }
        }

        for (int sandwich_type : sandwiches) {
            if (sandwich_type == 0) { // Current sandwich is circular
                if (count0 > 0) {
                    count0--; // A student who wants a circular sandwich takes it
                } else {
                    // No student wants a circular sandwich, so this sandwich cannot be eaten.
                    // All remaining students must want square sandwiches.
                    break;
                }
            } else { // Current sandwich is square
                if (count1 > 0) {
                    count1--; // A student who wants a square sandwich takes it
                } else {
                    // No student wants a square sandwich, so this sandwich cannot be eaten.
                    // All remaining students must want circular sandwiches.
                    break;
                }
            }
        }

        return count0 + count1; // Sum of students who couldn't eat
    }
};