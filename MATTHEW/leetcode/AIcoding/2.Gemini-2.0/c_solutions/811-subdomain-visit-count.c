#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *domain;
    int count;
} DomainCount;

char ** subdomainVisits(char ** cpdomains, int cpdomainsSize, int* returnSize){
    DomainCount *domainCounts = NULL;
    int domainCountSize = 0;

    for (int i = 0; i < cpdomainsSize; i++) {
        int count;
        char *domain = strchr(cpdomains[i], ' ');
        *domain = '\0';
        count = atoi(cpdomains[i]);
        domain++;

        char *subdomain = domain;
        while (subdomain != NULL) {
            int found = 0;
            for (int j = 0; j < domainCountSize; j++) {
                if (strcmp(domainCounts[j].domain, subdomain) == 0) {
                    domainCounts[j].count += count;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                domainCounts = realloc(domainCounts, (domainCountSize + 1) * sizeof(DomainCount));
                domainCounts[domainCountSize].domain = strdup(subdomain);
                domainCounts[domainCountSize].count = count;
                domainCountSize++;
            }
            subdomain = strchr(subdomain, '.');
            if (subdomain != NULL) {
                subdomain++;
            }
        }
    }

    char **result = malloc(domainCountSize * sizeof(char *));
    *returnSize = domainCountSize;
    for (int i = 0; i < domainCountSize; i++) {
        int len = snprintf(NULL, 0, "%d %s", domainCounts[i].count, domainCounts[i].domain);
        result[i] = malloc((len + 1) * sizeof(char));
        sprintf(result[i], "%d %s", domainCounts[i].count, domainCounts[i].domain);
        free(domainCounts[i].domain);
    }
    free(domainCounts);
    return result;
}