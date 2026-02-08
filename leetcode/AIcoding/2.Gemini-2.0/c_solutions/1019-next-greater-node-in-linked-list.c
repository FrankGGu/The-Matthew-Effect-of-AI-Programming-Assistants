#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* nextLargerNodes(struct ListNode* head, int* returnSize){
    int len = 0;
    struct ListNode* current = head;
    while (current != NULL) {
        len++;
        current = current->next;
    }

    int* result = (int*)malloc(sizeof(int) * len);
    *returnSize = len;

    int* stack = (int*)malloc(sizeof(int) * len);
    int top = -1;

    current = head;
    int index = 0;
    while (current != NULL) {
        while (top >= 0 && current->val > (head->val)) {
            struct ListNode* temp = head;
            int count = 0;
            int stack_index = stack[top];

            while(count < stack_index){
                temp = temp->next;
                count++;
            }
            result[stack[top--]] = current->val;

        }
        stack[++top] = index;
        result[index] = 0;
        head = head->next;
        current = head;
        index++;
    }

    free(stack);
    return result;
}