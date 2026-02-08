#include <string.h>
#include <stdbool.h>

static bool dp[16][16][1001];

int scoreOfStudents(char * s, int* answers, int answersSize){
    // Reset dp table for each test case.
    // sizeof(dp) is 16 * 16 * 1001 * sizeof(bool)
    memset(dp, 0, sizeof(dp)); 

    int n_str = strlen(s);
    int operands[16];
    char operators[15];
    int op_idx = 0;
    int oper_idx = 0;

    for (int i = 0; i < n_str; ++i) {
        if (i % 2 == 0) { // Digit
            operands[op_idx++] = s[i] - '0';
        } else { // Operator
            operators[oper_idx++] = s[i];
        }
    }
    int num_operands = op_idx;
    // int num_operators = oper_idx; // This is num_operands - 1

    // Base case: single operands
    for (int i = 0; i < num_operands; ++i) {
        // Operands are single digits (0-9), so they are always <= 1000
        dp[i][i][operands[i]] = true;
    }

    // Fill DP table: dp[i][j][val] is true if 'val' is a possible result
    // for the sub-expression from operand 'i' to operand 'j'.
    for (int len = 2; len <= num_operands; ++len) { // Length of sub-expression in terms of operands
        for (int i = 0; i <= num_operands - len; ++i) { // Starting operand index
            int j = i + len - 1; // Ending operand index
            for (int k = i; k < j; ++k) { // Split point (operator between operand k and k+1)
                char op_char = operators[k]; 
                for (int val1 = 0; val1 <= 1000; ++val1) {
                    if (dp[i][k][val1]) {
                        for (int val2 = 0; val2 <= 1000; ++val2) {
                            if (dp[k+1][j][val2]) {
                                int res;
                                if (op_char == '+') {
                                    res = val1 + val2;
                                } else { // '*'
                                    res = val1 * val2;
                                }
                                // Only store results that are within the student answer range
                                if (res <= 1000) {
                                    dp[i][j][res] = true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Calculate the standard correct answer (respecting operator precedence)
    // First pass: handle multiplications
    int current_nums[16];
    char current_ops[15];
    int current_num_idx = 0;
    int current_op_idx = 0;

    current_nums[current_num_idx++] = operands[0];

    for (int i = 0; i < num_operands - 1; ++i) { // Iterate through operators
        if (operators[i] == '*') {
            current_nums[current_num_idx - 1] *= operands[i+1];
        } else { // '+'
            current_nums[current_num_idx++] = operands[i+1];
            current_ops[current_op_idx++] = '+';
        }
    }

    // Second pass: handle additions
    long long actual_correct_answer = 0; // Use long long in case the true answer exceeds int max, though not likely to exceed 1000 * 1000
    if (current_num_idx > 0) {
        actual_correct_answer = current_nums[0];
        for (int i = 0; i < current_op_idx; ++i) {
            actual_correct_answer += current_nums[i+1];
        }
    }

    // Calculate total score
    int total_score = 0;
    for (int i = 0; i < answersSize; ++i) {
        int student_answer = answers[i];
        if (student_answer == actual_correct_answer) {
            total_score += 5;
        } else if (student_answer >= 0 && student_answer <= 1000 && dp[0][num_operands-1][student_answer]) {
            // student_answer >= 0 && student_answer <= 1000 is guaranteed by problem constraints
            total_score += 2;
        }
    }

    return total_score;
}