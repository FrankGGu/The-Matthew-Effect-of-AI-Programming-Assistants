#include <string.h>
#include <stdlib.h>

void swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(char *start, char *end) {
    while (start < end) {
        swap(start, end);
        start++;
        end--;
    }
}

int nextPermutation(char *s, int n) {
    // Find the largest index k such that s[k] < s[k+1]
    int k = n - 2;
    while (k >= 0 && s[k] >= s[k+1]) {
        k--;
    }

    // If no such index exists, it's the last permutation
    if (k < 0) {
        return 0; 
    }

    // Find the largest index l greater than k such that s[k] < s[l]
    int l = n - 1;
    while (l > k && s[k] >= s[l]) {
        l--;
    }

    // Swap s[k] and s[l]
    swap(&s[k], &s[l]);

    // Reverse the sub-array s[k+1...n-1]
    reverse(s + k + 1, s + n - 1);

    return 1;
}

int minSwaps(char *s1, char *s2, int n) {
    int swaps = 0;
    char temp_s1[n + 1];
    strcpy(temp_s1, s1);

    for (int i = 0; i < n; ++i) {
        if (temp_s1[i] == s2[i]) {
            continue;
        }

        // Find s2[i] in the remaining part of temp_s1 (from index i onwards)
        int j = i + 1;
        while (j < n && temp_s1[j] != s2[i]) {
            j++;
        }

        // Shift temp_s1[j] (which is s2[i]) to temp_s1[i] using adjacent swaps
        while (j > i) {
            swap(&temp_s1[j], &temp_s1[j-1]);
            swaps++;
            j--;
        }
    }
    return swaps;
}

int getMinSwaps(char *num, int k) {
    int n = strlen(num);

    // Store the original number for comparison later
    char original_num[n + 1];
    strcpy(original_num, num);

    // Create a mutable copy to generate the k-th next permutation
    char target_num[n + 1];
    strcpy(target_num, num);

    // Generate the k-th lexicographically next permutation
    for (int i = 0; i < k; ++i) {
        nextPermutation(target_num, n);
    }

    // Calculate the minimum adjacent swaps to transform original_num to target_num
    return minSwaps(original_num, target_num, n);
}