#include <stdbool.h>
#include <string.h> // For strlen, strncpy, strcmp

#define MAX_TAG_NAME_LEN 10
#define MAX_TAG_STACK_SIZE 200

typedef struct {
    char names[MAX_TAG_STACK_SIZE][MAX_TAG_NAME_LEN];
    int top;
} TagStack;

void initStack(TagStack* s) {
    s->top = -1;
}

bool push(TagStack* s, const char* tagName) {
    if (s->top >= MAX_TAG_STACK_SIZE - 1) {
        return false;
    }
    s->top++;
    strncpy(s->names[s->top], tagName, MAX_TAG_NAME_LEN - 1);
    s->names[s->top][MAX_TAG_NAME_LEN - 1] = '\0';
    return true;
}

bool pop(TagStack* s, char* tagNameBuffer) {
    if (s->top < 0) {
        return false;
    }
    strncpy(tagNameBuffer, s->names[s->top], MAX_TAG_NAME_LEN - 1);
    tagNameBuffer[MAX_TAG_NAME_LEN - 1] = '\0';
    s->top--;
    return true;
}

bool isEmpty(TagStack* s) {
    return s->top == -1;
}

bool isValid(char* code) {
    int n = strlen(code);
    TagStack s;
    initStack(&s);

    if (n == 0) return false;

    int i = 0;
    bool has_root_tag = false;

    while (i < n) {
        if (i == 0 && code[i] != '<') {
            return false;
        }

        if (code[i] == '<') {
            if (i + 8 < n &&
                code[i+1] == '!' &&
                code[i+2] == '[' &&
                code[i+3] == 'C' &&
                code[i+4] == 'D' &&
                code[i+5] == 'A' &&
                code[i+6] == 'T' &&
                code[i+7] == 'A' &&
                code[i+8] == '[') {

                if (isEmpty(&s)) return false;

                int cdata_start = i + 9;
                int cdata_end = -1;
                for (int j = cdata_start; j + 2 < n; ++j) {
                    if (code[j] == ']' && code[j+1] == ']' && code[j+2] == '>') {
                        cdata_end = j;
                        break;
                    }
                }
                if (cdata_end == -1) return false;

                i = cdata_end + 3;
            }
            else if (i + 1 < n && code[i+1] == '/') {
                int tag_start = i + 2;
                int tag_end = tag_start;
                while (tag_end < n && code[tag_end] != '>') {
                    if (!(code[tag_end] >= 'A' && code[tag_end] <= 'Z')) return false;
                    tag_end++;
                }

                if (tag_end == n) return false;
                if (tag_end == tag_start) return false;
                if (tag_end - tag_start > 9) return false;

                char current_tag_name[MAX_TAG_NAME_LEN];
                strncpy(current_tag_name, code + tag_start, tag_end - tag_start);
                current_tag_name[tag_end - tag_start] = '\0';

                if (isEmpty(&s)) return false;

                char popped_tag_name[MAX_TAG_NAME_LEN];
                pop(&s, popped_tag_name);

                if (strcmp(current_tag_name, popped_tag_name) != 0) return false;

                i = tag_end + 1;

                if (isEmpty(&s) && i < n) return false;
            }
            else if (i + 1 < n && (code[i+1] >= 'A' && code[i+1] <= 'Z')) {
                if (isEmpty(&s) && has_root_tag) return false;

                int tag_start = i + 1;
                int tag_end = tag_start;
                while (tag_end < n && code[tag_end] != '>') {
                    if (!(code[tag_end] >= 'A' && code[tag_end] <= 'Z')) return false;
                    tag_end++;
                }

                if (tag_end == n) return false;
                if (tag_end == tag_start) return false;
                if (tag_end - tag_start > 9) return false;

                char current_tag_name[MAX_TAG_NAME_LEN];
                strncpy(current_tag_name, code + tag_start, tag_end - tag_start);
                current_tag_name[tag_end - tag_start] = '\0';

                push(&s, current_tag_name);
                has_root_tag = true;

                i = tag_end + 1;
            }
            else {
                return false;
            }
        }
        else {
            if (!has_root_tag || isEmpty(&s)) return false;
            i++;
        }
    }

    return isEmpty(&s) && has_root_tag;
}