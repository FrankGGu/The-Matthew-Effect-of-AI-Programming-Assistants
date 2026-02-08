#include <string.h>
#include <ctype.h>

char *capitalizeTitle(char *title) {
    int n = strlen(title);
    int start = 0;
    for (int end = 0; end <= n; ++end) {
        if (end == n || title[end] == ' ') {
            int word_length = end - start;

            if (word_length <= 2) {
                for (int i = start; i < end; ++i) {
                    title[i] = tolower(title[i]);
                }
            } else {
                title[start] = toupper(title[start]);
                for (int i = start + 1; i < end; ++i) {
                    title[i] = tolower(title[i]);
                }
            }
            start = end + 1;
        }
    }
    return title;
}