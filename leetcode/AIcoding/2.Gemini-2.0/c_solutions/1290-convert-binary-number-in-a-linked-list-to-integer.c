#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getDecimalValue(struct ListNode* head){
    int num = 0;
    while (head != NULL) {
        num = (num << 1) | head->val;
        head = head->next;
    }
    return num;
}