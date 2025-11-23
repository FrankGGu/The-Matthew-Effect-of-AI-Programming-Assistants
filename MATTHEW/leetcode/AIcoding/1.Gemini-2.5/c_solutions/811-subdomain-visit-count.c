#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MAX_INTERMEDIATE_DOMAINS 300
#define MAX_DOMAIN_LEN 101 // +1 for null terminator
#define MAX_OUTPUT_STR_LEN (10 + 1 + 100 + 1) // 112

typedef struct {
    char domain[MAX_DOMAIN_LEN]; // Store domain directly in struct to avoid many small mallocs
    int count;
} DomainCount;

int compareDomainCount(const void *a, const void *b) {
    return strcmp(((DomainCount*)a)->domain, ((DomainCount*)b)->domain);
}

char ** subdomainVisits(char ** cpdomains, int cpdomainsSize, int* returnSize) {
    DomainCount all_subdomains[MAX_INTERMEDIATE_DOMAINS];
    int num_all_subdomains = 0;

    for (int i = 0; i < cpdomainsSize; i++) {
        int count;
        char full_domain_str[MAX_DOMAIN_LEN];

        // Parse count and domain string
        sscanf(cpdomains[i], "%d %s", &count, full_domain_str);

        char *current_subdomain_ptr = full_domain_str;
        while (current_subdomain_ptr != NULL) {
            strcpy(all_subdomains[num_all_subdomains].domain, current_subdomain_ptr);
            all_subdomains[num_all_subdomains].count = count;
            num_all_subdomains++;

            // Find the next dot
            char *dot_ptr = strchr(current_subdomain_ptr, '.');
            if (dot_ptr != NULL) {
                current_subdomain_ptr = dot_ptr + 1; // Move past the dot
            } else {
                current_subdomain_ptr = NULL; // No more dots, stop
            }
        }
    }

    // Sort all intermediate subdomains
    qsort(all_subdomains, num_all_subdomains, sizeof(DomainCount), compareDomainCount);

    // Prepare result array
    char **result = (char **) malloc(sizeof(char *) * MAX_INTERMEDIATE_DOMAINS);
    *returnSize = 0;

    if (num_all_subdomains == 0) {
        return result;
    }

    // Aggregate counts for unique subdomains
    for (int i = 0; i < num_all_subdomains; ) {
        int current_sum = all_subdomains[i].count;
        char *current_domain = all_subdomains[i].domain;
        int j = i + 1;

        while (j < num_all_subdomains && strcmp(all_subdomains[j].domain, current_domain) == 0) {
            current_sum += all_subdomains[j].count;
            j++;
        }

        // Format the output string
        char output_buffer[MAX_OUTPUT_STR_LEN];
        sprintf(output_buffer, "%d %s", current_sum, current_domain);

        // Allocate memory for the string and copy it
        result[*returnSize] = (char *) malloc(strlen(output_buffer) + 1);
        strcpy(result[*returnSize], output_buffer);
        (*returnSize)++;

        i = j; // Move to the next unique domain
    }

    return result;
}