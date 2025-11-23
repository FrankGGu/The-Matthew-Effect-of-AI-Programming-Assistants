#include <stdlib.h>
#include <string.h>

static int* parent_dsu;
static int N_dsu;

static int find_dsu(int i) {
    if (parent_dsu[i] == i) {
        return i;
    }
    return parent_dsu[i] = find_dsu(parent_dsu[i]);
}

static void unite_dsu(int i, int j) {
    int root_i = find_dsu(i);
    int root_j = find_dsu(j);
    if (root_i != root_j) {
        parent_dsu[root_j] = root_i;
    }
}

char* findTheString(int n, int** lcp, int lcpSize, int* lcpColSize) {
    // 1. Initialize DSU
    N_dsu = n;
    parent_dsu = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        parent_dsu[i] = i;
    }

    // 2. Apply constraints from LCP matrix (lcp[i][j] > 0 implies s[i] == s[j])
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (lcp[i][j] > 0) {
                unite_dsu(i, j);
            }
        }
    }

    // 3. Assign characters to components
    char* s = (char*)malloc((n + 1) * sizeof(char));
    char current_char_assign = 'a';
    char* component_char_map = (char*)malloc(n * sizeof(char)); // Stores the char assigned to the root of a component
    for (int i = 0; i < n; i++) {
        component_char_map[i] = 0; // 0 means unassigned
    }

    for (int i = 0; i < n; i++) {
        int root_i = find_dsu(i);
        if (component_char_map[root_i] == 0) { // If this component hasn't been assigned a character yet
            if (current_char_assign > 'z') { // Ran out of characters
                free(parent_dsu);
                free(s);
                free(component_char_map);
                return ""; // Return empty string
            }
            component_char_map[root_i] = current_char_assign;
            current_char_assign++;
        }
        s[i] = component_char_map[root_i];
    }
    s[n] = '\0'; // Null-terminate the string

    // 4. Verification: Recompute LCP for the constructed string and compare
    int** actual_lcp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        actual_lcp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = n - 1; i >= 0; i--) {
        actual_lcp[i][i] = n - i;
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                actual_lcp[i][j] = 1 + ((i + 1 < n && j + 1 < n) ? actual_lcp[i + 1][j + 1] : 0);
            } else {
                actual_lcp[i][j] = 0;
            }
            actual_lcp[j][i] = actual_lcp[i][j]; // Symmetric
        }
    }

    // Compare with given lcp
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (lcp[i][j] != actual_lcp[i][j]) {
                free(parent_dsu);
                free(s);
                free(component_char_map);
                for (int k = 0; k < n; k++) {
                    free(actual_lcp[k]);
                }
                free(actual_lcp);
                return ""; // Mismatch, return empty string
            }
        }
    }

    // If all checks pass, return the constructed string
    free(parent_dsu);
    free(component_char_map);
    for (int k = 0; k < n; k++) {
        free(actual_lcp[k]);
    }
    free(actual_lcp);
    return s;
}