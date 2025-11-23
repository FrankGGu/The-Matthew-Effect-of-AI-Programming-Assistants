class Solution {
    public int countStudents(int[] students, int[] sandwiches) {
        int count0 = 0; // Number of students who want sandwich type 0
        int count1 = 0; // Number of students who want sandwich type 1

        // Count the preferences of students
        for (int student : students) {
            if (student == 0) {
                count0++;
            } else {
                count1++;
            }
        }

        // Iterate through the sandwiches
        for (int sandwich : sandwiches) {
            if (sandwich == 0) { // Current sandwich is type 0
                if (count0 > 0) { // If there's a student who wants type 0
                    count0--; // A student takes the sandwich
                } else { // No student wants type 0, so no one can eat this sandwich or subsequent ones
                    break;
                }
            } else { // Current sandwich is type 1
                if (count1 > 0) { // If there's a student who wants type 1
                    count1--; // A student takes the sandwich
                } else { // No student wants type 1, so no one can eat this sandwich or subsequent ones
                    break;
                }
            }
        }

        // The remaining students are those who couldn't get their preferred sandwich
        return count0 + count1;
    }
}