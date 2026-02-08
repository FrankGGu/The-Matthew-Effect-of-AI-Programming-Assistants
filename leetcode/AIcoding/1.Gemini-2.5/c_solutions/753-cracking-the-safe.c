#include <stdlib.h>
#include <string.h>
#include <stdbool.h> // For bool type

char* result_str;
int result_idx;
bool* visited_passwords;
int total_passwords_found; // Tracks how many unique n-digit passwords have been appended
int max_passwords;         // k^n, the total number of unique n-digit passwords
int N_global, K_global;
int prefix_mod_val;        // k^(n-1), used to get the next (n-1)-digit prefix

void dfs(int current_prefix_val) {
    // Iterate through all possible digits from k-1 down to 0
    for (int digit = K_global - 1; digit >= 0; --digit) {
        // Form the n-digit password by appending the current digit to the (n-1)-digit prefix
        int password_val = current_prefix_val * K_global + digit;

        // If this n-digit password has not been visited yet (i.e., this edge not traversed)
        if (!visited_passwords[password_val]) {
            // Mark the password as visited
            visited_passwords[password_val] = true;
            // Append the current digit to the result string
            result_str[result_idx++] = digit + '0';
            // Increment the count of found unique passwords
            total_passwords_found++;

            // Calculate the next (n-1)-digit prefix by taking the last n-1 digits of the current password
            int next_prefix_val = password_val % prefix_mod_val;

            // Recursively call DFS with the new prefix
            dfs(next_prefix_val);

            // Optimization: If all unique passwords have been found, we can stop further exploration
            // This means we have found an Eulerian path covering all edges.
            if (total_passwords_found == max_passwords) {
                return;
            }
        }
    }
}

char* crackSafe(int n, int k) {
    N_global = n;
    K_global = k;

    // Calculate max_passwords (k^n) and prefix_mod_val (k^(n-1))
    max_passwords = 1;
    prefix_mod_val = 1;
    for (int i = 0; i < n; ++i) {
        max_passwords *= k;
        if (i < n - 1) {
            prefix_mod_val *= k;
        }
    }
    // Special case for n=1: prefix_mod_val should be k^0 = 1
    // The loop correctly handles this as i < n-1 (i < 0) is never true.

    // Allocate memory for the visited_passwords array
    // calloc initializes all elements to false (0)
    visited_passwords = (bool*)calloc(max_passwords, sizeof(bool));
    if (visited_passwords == NULL) {
        return NULL; // Handle allocation error
    }

    // Allocate memory for the result string
    // The length of a De Bruijn sequence is k^n + n - 1
    int result_len = max_passwords + n - 1;
    result_str = (char*)malloc((result_len + 1) * sizeof(char)); // +1 for null terminator
    if (result_str == NULL) {
        free(visited_passwords); // Clean up previously allocated memory
        return NULL; // Handle allocation error
    }
    result_str[result_len] = '\0'; // Null-terminate the string

    // Initialize the result string with n-1 zeros. This forms the starting prefix.
    result_idx = 0;
    for (int i = 0; i < n - 1; ++i) {
        result_str[result_idx++] = '0';
    }

    total_passwords_found = 0;
    int initial_prefix_val = 0; // Represents the (n-1)-digit prefix of all zeros

    // Start the DFS traversal from the initial prefix
    dfs(initial_prefix_val);

    // Free the memory allocated for visited_passwords
    free(visited_passwords);

    // Return the constructed De Bruijn sequence
    return result_str;
}