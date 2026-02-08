int countStudents(int* students, int studentsSize, int* sandwiches, int sandwichesSize) {
    int count0 = 0; // Number of students who want type 0 sandwiches
    int count1 = 0; // Number of students who want type 1 sandwiches

    // Count initial preferences of students
    for (int i = 0; i < studentsSize; i++) {
        if (students[i] == 0) {
            count0++;
        } else {
            count1++;
        }
    }

    // Process sandwiches from the stack top
    for (int i = 0; i < sandwichesSize; i++) {
        if (sandwiches[i] == 0) { // Current sandwich is type 0
            if (count0 > 0) { // A student who wants type 0 is available
                count0--; // Student takes the sandwich
            } else { // No student wants type 0, so no one will take this sandwich or any subsequent ones
                return count1; // The remaining students all want type 1 and cannot eat
            }
        } else { // Current sandwich is type 1
            if (count1 > 0) { // A student who wants type 1 is available
                count1--; // Student takes the sandwich
            } else { // No student wants type 1, so no one will take this sandwich or any subsequent ones
                return count0; // The remaining students all want type 0 and cannot eat
            }
        }
    }

    // If the loop completes, all sandwiches have been eaten, meaning all students got their lunch
    return 0;
}