#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

#define MAX_VAR_NAME_LEN 20
#define MAX_VARS_PER_SCOPE 50

typedef struct {
    char name[MAX_VAR_NAME_LEN + 1];
    int value;
} VarEntry;

typedef struct Env {
    VarEntry vars[MAX_VARS_PER_SCOPE];
    int count;
    struct Env* parent;
} Env;

Env* g_current_env;
char* g_expression;
int g_pos;

void push_scope() {
    Env* new_env = (Env*)malloc(sizeof(Env));
    new_env->count = 0;
    new_env->parent = g_current_env;
    g_current_env = new_env;
}

void pop_scope() {
    Env* old_env = g_current_env;
    g_current_env = g_current_env->parent;
    free(old_env);
}

void add_var(const char* name, int value) {
    strcpy(g_current_env->vars[g_current_env->count].name, name);
    g_current_env->vars[g_current_env->count].value = value;
    g_current_env->count++;
}

int find_var(const char* name) {
    Env* env_ptr = g_current_env;
    while (env_ptr != NULL) {
        for (int i = env_ptr->count - 1; i >= 0; --i) {
            if (strcmp(env_ptr->vars[i].name, name) == 0) {
                return env_ptr->vars[i].value;
            }
        }
        env_ptr = env_ptr->parent;
    }
    return 0;
}

void skip_whitespace() {
    while (g_expression[g_pos] == ' ') {
        g_pos++;
    }
}

int parse_integer() {
    int sign = 1;
    if (g_expression[g_pos] == '-') {
        sign = -1;
        g_pos++;
    }
    int num = 0;
    while (isdigit(g_expression[g_pos])) {
        num = num * 10 + (g_expression[g_pos] - '0');
        g_pos++;
    }
    return sign * num;
}

void parse_token(char* buffer) {
    int i = 0;
    while (g_expression[g_pos] != ' ' && g_expression[g_pos] != ')' && g_expression[g_pos] != '\0') {
        buffer[i++] = g_expression[g_pos++];
    }
    buffer[i] = '\0';
}

bool peek_is_var_name_to_bind() {
    int temp_pos = g_pos;
    skip_whitespace();

    char first_char = g_expression[g_pos];
    if (!isalpha(first_char) && first_char != '_') {
        g_pos = temp_pos;
        return false;
    }

    while (g_expression[g_pos] != ' ' && g_expression[g_pos] != ')' && g_expression[g_pos] != '\0') {
        g_pos++;
    }

    skip_whitespace();
    bool is_followed_by_another_element = (g_expression[g_pos] != ')');

    g_pos = temp_pos;
    return is_followed_by_another_element;
}

int parse_expression() {
    skip_whitespace();

    if (g_expression[g_pos] == '(') {
        g_pos++;
        skip_whitespace();

        char token[MAX_VAR_NAME_LEN + 1];
        parse_token(token);
        skip_whitespace();

        if (strcmp(token, "let") == 0) {
            push_scope();
            int result;
            while (true) {
                if (peek_is_var_name_to_bind()) {
                    char var_name[MAX_VAR_NAME_LEN + 1];
                    parse_token(var_name);
                    skip_whitespace();
                    int var_value = parse_expression();
                    add_var(var_name, var_value);
                    skip_whitespace();
                } else {
                    result = parse_expression();
                    break;
                }
            }
            pop_scope();
            g_pos++;
            return result;
        } else if (strcmp(token, "add") == 0) {
            int exp1 = parse_expression();
            skip_whitespace();
            int exp2 = parse_expression();
            g_pos++;
            return exp1 + exp2;
        } else if (strcmp(token, "mult") == 0) {
            int exp1 = parse_expression();
            skip_whitespace();
            int exp2 = parse_expression();
            g_pos++;
            return exp1 * exp2;
        }
    } else if (isdigit(g_expression[g_pos]) || (g_expression[g_pos] == '-' && isdigit(g_expression[g_pos+1]))) {
        return parse_integer();
    } else {
        char var_name[MAX_VAR_NAME_LEN + 1];
        parse_token(var_name);
        return find_var(var_name);
    }
    return 0;
}

int evaluate(char* expression) {
    g_expression = expression;
    g_pos = 0;
    g_current_env = NULL;

    int result = parse_expression();

    while (g_current_env != NULL) {
        pop_scope();
    }

    return result;
}