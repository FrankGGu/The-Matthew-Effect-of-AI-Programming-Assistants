#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

typedef struct {
    char name[3]; // Max 2 chars for name + null terminator
    long long count; // Count can be up to 10^9, so long long is appropriate
} AtomCount;

typedef struct {
    AtomCount *data;
    int size;
    int capacity;
} AtomVector;

int compareAtomCounts(const void *a, const void *b) {
    return strcmp(((AtomCount*)a)->name, ((AtomCount*)b)->name);
}

void init_atom_vector(AtomVector *vec) {
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

void free_atom_vector(AtomVector *vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

void push_atom_to_vector(AtomVector *vec, const char *name, long long count) {
    if (vec->size == vec->capacity) {
        vec->capacity = (vec->capacity == 0) ? 4 : vec->capacity * 2;
        vec->data = (AtomCount*)realloc(vec->data, vec->capacity * sizeof(AtomCount));
    }
    strcpy(vec->data[vec->size].name, name);
    vec->data[vec->size].count = count;
    vec->size++;
}

void sort_and_merge_duplicates_atom_vector(AtomVector *vec) {
    if (vec->size <= 1) return;

    qsort(vec->data, vec->size, sizeof(AtomCount), compareAtomCounts);

    int write_idx = 0;
    for (int read_idx = 0; read_idx < vec->size; read_idx++) {
        if (read_idx == 0 || strcmp(vec->data[read_idx].name, vec->data[read_idx - 1].name) != 0) {
            // New unique atom, copy it to the current write position
            vec->data[write_idx++] = vec->data[read_idx];
        } else {
            // Duplicate atom, add its count to the previous (merged) atom
            vec->data[write_idx - 1].count += vec->data[read_idx].count;
        }
    }
    vec->size = write_idx; // Update the size of the vector after merging
}

void merge_vectors(AtomVector *dest, AtomVector *src, long long multiplier) {
    for (int i = 0; i < src->size; i++) {
        push_atom_to_vector(dest, src->data[i].name, src->data[i].count * multiplier);
    }
    sort_and_merge_duplicates_atom_vector(dest);
}

char* countOfAtoms(char* formula) {
    int n = strlen(formula);
    int i = 0;

    // Stack to hold AtomVectors for different scopes (parentheses)
    // Max depth can be n/2 (e.g., "((()))"), plus one for the base level.
    AtomVector stack_of_vectors[n / 2 + 2]; 
    int top = -1;

    // Initialize the base vector for the outermost scope
    top++;
    init_atom_vector(&stack_of_vectors[top]);

    while (i < n) {
        if (formula[i] == '(') {
            // Push a new empty vector onto the stack for the new scope
            top++;
            init_atom_vector(&stack_of_vectors[top]);
            i++;
        } else if (formula[i] == ')') {
            // End of a scope, read the multiplier
            i++;
            long long num = 0;
            while (i < n && isdigit(formula[i])) {
                num = num * 10 + (formula[i] - '0');
                i++;
            }
            if (num == 0) num = 1; // Default multiplier is 1 if no number follows

            // Pop the current scope's atoms and merge them into the parent scope
            // applying the multiplier 'num'.
            merge_vectors(&stack_of_vectors[top-1], &stack_of_vectors[top], num);

            // Free the memory of the popped vector
            free_atom_vector(&stack_of_vectors[top]);
            top--; // Move stack pointer down
        } else { // Atom name (starts with an uppercase letter)
            char atom_name[3]; // Buffer for atom name (e.g., "H", "Mg")
            atom_name[0] = formula[i++]; // First char is always uppercase

            // Check for a second (lowercase) letter
            if (i < n && islower(formula[i])) {
                atom_name[1] = formula[i++];
                atom_name[2] = '\0';
            } else {
                atom_name[1] = '\0';
            }

            // Read the count for this atom
            long long num = 0;
            while (i < n && isdigit(formula[i])) {
                num = num * 10 + (formula[i] - '0');
                i++;
            }
            if (num == 0) num = 1; // Default count is 1 if no number follows

            // Add the atom to the current scope's vector
            push_atom_to_vector(&stack_of_vectors[top], atom_name, num);
        }
    }

    // After parsing, stack_of_vectors[0] contains all atoms from the entire formula.
    // Ensure it's sorted and duplicates are merged one last time.
    sort_and_merge_duplicates_atom_vector(&stack_of_vectors[0]); 

    // Now, format the final output string
    AtomVector *final_atoms = &stack_of_vectors[0];
    int total_len = 0;

    // Calculate the total length needed for the result string
    for (int k = 0; k < final_atoms->size; k++) {
        total_len += strlen(final_atoms->data[k].name);
        if (final_atoms->data[k].count > 1) {
            // Use snprintf with NULL and 0 to get the length without writing
            total_len += snprintf(NULL, 0, "%lld", final_atoms->data[k].count);
        }
    }
    total_len++; // For the null terminator

    char *result = (char*)malloc(total_len);
    char *ptr = result;

    // Populate the result string
    for (int k = 0; k < final_atoms->size; k++) {
        ptr += sprintf(ptr, "%s", final_atoms->data[k].name);
        if (final_atoms->data[k].count > 1) {
            ptr += sprintf(ptr, "%lld", final_atoms->data[k].count);
        }
    }
    *ptr = '\0'; // Ensure null termination

    // Free the memory of the final AtomVector
    free_atom_vector(&stack_of_vectors[0]);

    return result; // Caller is responsible for freeing this string
}