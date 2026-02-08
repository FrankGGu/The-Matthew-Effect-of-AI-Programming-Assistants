#include <stdbool.h>

static bool evaluate(char* expression, int* idx) {
    char current_char = expression[*idx];

    if (current_char == 't') {
        (*idx)++;
        return true;
    }
    if (current_char == 'f') {
        (*idx)++;
        return false;
    }

    char op = current_char;
    (*idx)++; 
    (*idx)++; 

    bool result;
    if (op == '!') {
        result = !evaluate(expression, idx);
    } else if (op == '&') {
        result = true; 
        while (expression[*idx] != ')') {
            result = result && evaluate(expression, idx);
            if (expression[*idx] == ',') {
                (*idx)++; 
            }
        }
    } else { 
        result = false; 
        while (expression[*idx] != ')') {
            result = result || evaluate(expression, idx);
            if (expression[*idx] == ',') {
                (*idx)++; 
            }
        }
    }

    (*idx)++; 
    return result;
}

bool parseBoolExpr(char* expression) {
    int idx = 0;
    return evaluate(expression, &idx);
}