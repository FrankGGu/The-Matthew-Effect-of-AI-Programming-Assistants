#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

struct ListNode* insertGreatestCommonDivisors(struct ListNode* head){
    if (!head || !head->next) return head;

    struct ListNode* curr = head;
    while (curr && curr->next) {
        int g = gcd(curr->val, curr->next->val);
        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
        newNode->val = g;
        newNode->next = curr->next;
        curr->next = newNode;
        curr = newNode->next;
    }

    return head;
}