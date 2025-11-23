#include <string.h>
#include <stdbool.h>

char *smallestString(char *s1, char *s2, char *s3) {
    int len1 = strlen(s1), len2 = strlen(s2), len3 = strlen(s3);
    int min_len = len1 + len2 + len3 + 1;
    char *result = (char *)malloc(min_len * sizeof(char));
    result[0] = '\0';

    for (int i = 0; i < len1; i++) {
        for (int j = 0; j < len2; j++) {
            for (int k = 0; k < len3; k++) {
                char temp[1000];
                int index = 0;
                bool used1 = false, used2 = false, used3 = false;

                for (int l = 0; l < len1 + len2 + len3; l++) {
                    if (l == i) {
                        for (int m = 0; m < len1; m++) {
                            if (m != i) temp[index++] = s1[m];
                        }
                        used1 = true;
                    }
                    if (l == j + len1) {
                        for (int m = 0; m < len2; m++) {
                            if (m != j) temp[index++] = s2[m];
                        }
                        used2 = true;
                    }
                    if (l == k + len1 + len2) {
                        for (int m = 0; m < len3; m++) {
                            if (m != k) temp[index++] = s3[m];
                        }
                        used3 = true;
                    }
                }

                if (used1 && used2 && used3) {
                    temp[index] = '\0';
                    if (strlen(temp) < min_len) {
                        min_len = strlen(temp);
                        strcpy(result, temp);
                    }
                }
            }
        }
    }

    return result;
}