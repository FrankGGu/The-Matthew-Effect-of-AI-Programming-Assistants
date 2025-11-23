#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countStudents(int* students, int studentsSize, int* sandwiches, int sandwichesSize){
    int student_zeros = 0;
    int student_ones = 0;

    for(int i = 0; i < studentsSize; i++){
        if(students[i] == 0){
            student_zeros++;
        } else {
            student_ones++;
        }
    }

    for(int i = 0; i < sandwichesSize; i++){
        if(sandwiches[i] == 0){
            if(student_zeros > 0){
                student_zeros--;
            } else {
                return student_ones;
            }
        } else {
            if(student_ones > 0){
                student_ones--;
            } else {
                return student_zeros;
            }
        }
    }

    return 0;
}