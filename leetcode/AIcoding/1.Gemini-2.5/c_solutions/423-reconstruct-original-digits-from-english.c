#include <stdlib.h>
#include <string.h>

char * originalDigits(char * s){
    int freq[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        freq[s[i] - 'a']++;
    }

    int digit_counts[10] = {0};

    // Digits with unique identifying characters
    // zero: z
    digit_counts[0] = freq['z' - 'a'];
    // two: w
    digit_counts[2] = freq['w' - 'a'];
    // four: u
    digit_counts[4] = freq['u' - 'a'];
    // six: x
    digit_counts[6] = freq['x' - 'a'];
    // eight: g
    digit_counts[8] = freq['g' - 'a'];

    // Digits identified by subtracting known counts
    // three: h (in three, eight)
    digit_counts[3] = freq['h' - 'a'] - digit_counts[8];
    // five: f (in four, five)
    digit_counts[5] = freq['f' - 'a'] - digit_counts[4];
    // seven: s (in six, seven)
    digit_counts[7] = freq['s' - 'a'] - digit_counts[6];

    // Remaining digits
    // one: o (in zero, one, two, four)
    digit_counts[1] = freq['o' - 'a'] - digit_counts[0] - digit_counts[2] - digit_counts[4];
    // nine: i (in five, six, eight, nine)
    digit_counts[9] = freq['i' - 'a'] - digit_counts[5] - digit_counts[6] - digit_counts[8];

    // Construct the result string
    int total_digits = 0;
    for (int i = 0; i < 10; i++) {
        total_digits += digit_counts[i];
    }

    char *result = (char *)malloc(sizeof(char) * (total_digits + 1));
    if (result == NULL) {
        return NULL; 
    }
    char *p = result;

    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < digit_counts[i]; j++) {
            *p++ = (char)(i + '0');
        }
    }
    *p = '\0';

    return result;
}