#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseKGroup(struct ListNode* head, int k) {
    if (!head || !head->next || k <= 1) {
        return head;
    }

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* pre = dummy;
    struct ListNode* cur = head;
    int len = 0;
    struct ListNode* temp = head;
    while (temp) {
        len++;
        temp = temp->next;
    }

    int group_num = 1;
    while (cur) {
        int group_len = group_num;
        if (len < group_len) {
            group_len = len;
        }

        if (group_len % 2 == 0) {
            struct ListNode* next_group_start = cur;
            struct ListNode* prev = NULL;
            struct ListNode* curr = cur;
            struct ListNode* next = NULL;

            for (int i = 0; i < group_len; i++) {
                next = curr->next;
                curr->next = prev;
                prev = curr;
                curr = next;
            }

            pre->next = prev;
            next_group_start->next = curr;
            pre = next_group_start;
            cur = curr;
        } else {
            for (int i = 0; i < group_len; i++) {
                pre = cur;
                cur = cur->next;
            }
        }
        len -= group_num;
        group_num++;
        if (len <= 0) break;
    }

    return dummy->next;
}