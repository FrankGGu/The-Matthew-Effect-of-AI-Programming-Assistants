#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *expr;
    int index;
} Parser;

Parser* create_parser(char *expr) {
    Parser *p = (Parser*)malloc(sizeof(Parser));
    p->expr = expr;
    p->index = 0;
    return p;
}

char peek(Parser *p) {
    return p->expr[p->index];
}

char consume(Parser *p) {
    return p->expr[p->index++];
}

int is_digit(char c) {
    return c >= '0' && c <= '9';
}

int is_letter(char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

int parse_boolean(Parser *p) {
    char c = peek(p);
    if (c == 't') {
        consume(p);
        return 1;
    } else if (c == 'f') {
        consume(p);
        return 0;
    } else if (c == '(') {
        consume(p); // '('
        int val = parse_expr(p);
        consume(p); // ')'
        return val;
    } else {
        return 0; // should not reach here for valid input
    }
}

int parse_expr(Parser *p) {
    int val = parse_term(p);
    while (peek(p) == ' ') {
        consume(p);
    }
    if (peek(p) == '&') {
        consume(p);
        int right = parse_expr(p);
        return val && right;
    } else if (peek(p) == '|') {
        consume(p);
        int right = parse_expr(p);
        return val || right;
    } else {
        return val;
    }
}

int parse_term(Parser *p) {
    int val = parse_factor(p);
    while (peek(p) == ' ') {
        consume(p);
    }
    if (peek(p) == '!') {
        consume(p);
        return !val;
    } else {
        return val;
    }
}

int parse_factor(Parser *p) {
    return parse_boolean(p);
}

bool parseBoolExpr(char *expression) {
    Parser *p = create_parser(expression);
    int result = parse_expr(p);
    free(p);
    return result;
}