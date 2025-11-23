#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* value;
    int is_list;
    struct LispNode** children;
    int child_count;
} LispNode;

typedef struct {
    char* tokens;
    int pos;
} Parser;

LispNode* parse_lisp(char* expression) {
    Parser p;
    p.tokens = expression;
    p.pos = 0;
    return parse_expression(&p);
}

LispNode* parse_expression(Parser* p) {
    while (p->pos < strlen(p->tokens) && p->tokens[p->pos] == ' ')
        p->pos++;
    if (p->tokens[p->pos] == '(') {
        p->pos++;
        LispNode* node = (LispNode*)malloc(sizeof(LispNode));
        node->is_list = 1;
        node->children = NULL;
        node->child_count = 0;
        while (p->tokens[p->pos] != ')') {
            LispNode* child = parse_expression(p);
            if (node->children == NULL) {
                node->children = (LispNode**)malloc(sizeof(LispNode*));
            } else {
                node->children = (LispNode**)realloc(node->children, (node->child_count + 1) * sizeof(LispNode*));
            }
            node->children[node->child_count++] = child;
            while (p->pos < strlen(p->tokens) && p->tokens[p->pos] == ' ')
                p->pos++;
        }
        p->pos++;
        return node;
    } else {
        int start = p->pos;
        while (p->pos < strlen(p->tokens) && p->tokens[p->pos] != ' ' && p->tokens[p->pos] != ')') {
            p->pos++;
        }
        int len = p->pos - start;
        char* value = (char*)malloc(len + 1);
        strncpy(value, p->tokens + start, len);
        value[len] = '\0';
        LispNode* node = (LispNode*)malloc(sizeof(LispNode));
        node->value = value;
        node->is_list = 0;
        node->children = NULL;
        node->child_count = 0;
        return node;
    }
}

void free_lisp_node(LispNode* node) {
    if (!node)
        return;
    if (node->is_list) {
        for (int i = 0; i < node->child_count; i++) {
            free_lisp_node(node->children[i]);
        }
        free(node->children);
    } else {
        free(node->value);
    }
    free(node);
}