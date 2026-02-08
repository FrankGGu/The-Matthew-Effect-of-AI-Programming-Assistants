#include <stdlib.h>

#define MAX_STACK_SIZE 1000

int stack1_data[MAX_STACK_SIZE];
int stack1_top;

int stack2_data[MAX_STACK_SIZE];
int stack2_top;

void init_stack(int* top_ptr) {
    *top_ptr = -1;
}

void push_val(int* stack_data, int* top_ptr, int val) {
    stack_data[++(*top_ptr)] = val;
}

int pop_val(int* stack_data, int* top_ptr) {
    return stack_data[(*top_ptr)--];
}

int is_empty(int* top_ptr) {
    return *top_ptr == -1;
}

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    init_stack(&stack1_top);
    init_stack(&stack2_top);

    struct ListNode* current = l1;
    while (current != NULL) {
        push_val(stack1_data, &stack1_top, current->val);
        current = current->next;
    }

    current = l2;
    while (current != NULL) {
        push_val(stack2_data, &stack2_top, current->val);
        current = current->next;
    }

    int carry = 0;
    struct ListNode* resultHead = NULL;

    while (!is_empty(&stack1_top) || !is_empty(&stack2_top) || carry != 0) {
        int sum = carry;
        if (!is_empty(&stack1_top)) {
            sum += pop_val(stack1_data, &stack1_top);
        }
        if (!is_empty(&stack2_top)) {
            sum += pop_val(stack2_data, &stack2_top);
        }

        carry = sum / 10;
        int digit = sum % 10;

        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
        newNode->val = digit;
        newNode->next = resultHead;
        resultHead = newNode;
    }

    return resultHead;
}