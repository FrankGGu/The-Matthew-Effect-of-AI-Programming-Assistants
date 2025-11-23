#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int* spiralMatrix(int m, int n, struct ListNode* head) {
    int* result = (int*)malloc(m * n * sizeof(int));
    int index = 0;

    int top = 0, bottom = m - 1;
    int left = 0, right = n - 1;

    while (top <= bottom && left <= right && head != NULL) {
        for (int i = left; i <= right && head != NULL; i++) {
            result[index++] = head->val;
            head = head->next;
        }
        top++;

        for (int i = top; i <= bottom && head != NULL; i++) {
            result[index++] = head->val;
            head = head->next;
        }
        right--;

        for (int i = right; i >= left && head != NULL; i--) {
            result[index++] = head->val;
            head = head->next;
        }
        bottom--;

        for (int i = bottom; i >= top && head != NULL; i--) {
            result[index++] = head->val;
            head = head->next;
        }
        left++;
    }

    return result;
}