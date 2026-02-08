#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

int compareInts(const void* a, const void* b) {
    return (*(const int*)a - *(const int*)b);
}

bool isSubset(int* listA, int sizeA, int* listB, int sizeB) {
    if (sizeA > sizeB) {
        return false;
    }
    int ptrA = 0;
    int ptrB = 0;
    while (ptrA < sizeA && ptrB < sizeB) {
        if (listA[ptrA] == listB[ptrB]) {
            ptrA++;
            ptrB++;
        } else if (listA[ptrA] < listB[ptrB]) {
            return false;
        } else {
            ptrB++;
        }
    }
    return ptrA == sizeA;
}

int* peopleWhoseListOfFavoriteCompaniesIsNotASubsetOfAnotherList(
    char*** favoriteCompanies, int favoriteCompaniesSize, int* favoriteCompaniesColSize, int* returnSize) {

    char** all_company_names_temp = NULL;
    int total_companies_count = 0;
    int current_capacity = 0;

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        for (int j = 0; j < favoriteCompaniesColSize[i]; j++) {
            if (total_companies_count >= current_capacity) {
                current_capacity = current_capacity == 0 ? 100 : current_capacity * 2;
                all_company_names_temp = (char**)realloc(all_company_names_temp, current_capacity * sizeof(char*));
            }
            all_company_names_temp[total_companies_count++] = favoriteCompanies[i][j];
        }
    }

    qsort(all_company_names_temp, total_companies_count, sizeof(char*), compareStrings);

    char** unique_companies = NULL;
    int unique_count = 0;
    current_capacity = 0;

    if (total_companies_count > 0) {
        current_capacity = 100;
        unique_companies = (char**)malloc(current_capacity * sizeof(char*));
        unique_companies[unique_count++] = all_company_names_temp[0];

        for (int i = 1; i < total_companies_count; i++) {
            if (strcmp(all_company_names_temp[i], unique_companies[unique_count - 1]) != 0) {
                if (unique_count >= current_capacity) {
                    current_capacity *= 2;
                    unique_companies = (char**)realloc(unique_companies, current_capacity * sizeof(char*));
                }
                unique_companies[unique_count++] = all_company_names_temp[i];
            }
        }
    }

    free(all_company_names_temp);

    int** companies_int = (int**)malloc(favoriteCompaniesSize * sizeof(int*));
    for (int i = 0; i < favoriteCompaniesSize; i++) {
        int num_companies_for_person = favoriteCompaniesColSize[i];
        companies_int[i] = (int*)malloc(num_companies_for_person * sizeof(int));
        for (int j = 0; j < num_companies_for_person; j++) {
            char* key = favoriteCompanies[i][j];
            char** found_ptr = (char**)bsearch(&key, unique_companies, unique_count, sizeof(char*), compareStrings);
            companies_int[i][j] = (found_ptr != NULL) ? (int)(found_ptr - unique_companies) : 0;
        }
        qsort(companies_int[i], num_companies_for_person, sizeof(int), compareInts);
    }

    int* result = (int*)malloc(favoriteCompaniesSize * sizeof(int));
    int result_count = 0;

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        bool is_subset_of_another = false;
        for (int j = 0; j < favoriteCompaniesSize; j++) {
            if (i == j) {
                continue;
            }
            if (isSubset(companies_int[i], favoriteCompaniesColSize[i],
                         companies_int[j], favoriteCompaniesColSize[j])) {
                is_subset_of_another = true;
                break;
            }
        }
        if (!is_subset_of_another) {
            result[result_count++] = i;
        }
    }

    for (int i = 0; i < favoriteCompaniesSize; i++) {
        free(companies_int[i]);
    }
    free(companies_int);
    free(unique_companies);

    *returnSize = result_count;
    return (int*)realloc(result, result_count * sizeof(int));
}