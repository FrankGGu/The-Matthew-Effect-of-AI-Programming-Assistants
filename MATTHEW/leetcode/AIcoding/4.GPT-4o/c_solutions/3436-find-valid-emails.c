#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    char *email;
    struct ListNode *next;
};

struct ListNode* add_email(struct ListNode* head, char* email) {
    struct ListNode* new_node = (struct ListNode*)malloc(sizeof(struct ListNode));
    new_node->email = strdup(email);
    new_node->next = head;
    return new_node;
}

int is_valid_email(char* email) {
    char *at = strchr(email, '@');
    char *dot;
    if (at == NULL || at == email || at[1] == '\0') return 0;
    dot = strrchr(email, '.');
    if (dot == NULL || dot < at + 1 || dot[1] == '\0') return 0;
    return 1;
}

struct ListNode* find_valid_emails(char** emails, int emailsSize) {
    struct ListNode* valid_emails = NULL;
    for (int i = 0; i < emailsSize; i++) {
        if (is_valid_email(emails[i])) {
            valid_emails = add_email(valid_emails, emails[i]);
        }
    }
    return valid_emails;
}

void free_list(struct ListNode* head) {
    while (head) {
        struct ListNode* temp = head;
        head = head->next;
        free(temp->email);
        free(temp);
    }
}

struct ListNode* findValidEmails(char** emails, int emailsSize) {
    return find_valid_emails(emails, emailsSize);
}