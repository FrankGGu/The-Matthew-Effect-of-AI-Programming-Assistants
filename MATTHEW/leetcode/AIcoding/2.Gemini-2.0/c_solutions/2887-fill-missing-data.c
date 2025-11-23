#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Employee {
    int id;
    char name[50];
    int salary;
    struct Employee *next;
};

struct Employee* fillMissingData(struct Employee* head) {
    struct Employee* current = head;
    struct Employee* prev = NULL;

    while (current != NULL) {
        if (current->salary == -1) {
            int sum = 0;
            int count = 0;
            struct Employee* temp = head;
            while (temp != NULL) {
                if (temp->salary != -1) {
                    sum += temp->salary;
                    count++;
                }
                temp = temp->next;
            }
            if (count > 0) {
                current->salary = sum / count;
            } else {
                current->salary = 0;
            }
        }
        prev = current;
        current = current->next;
    }

    return head;
}