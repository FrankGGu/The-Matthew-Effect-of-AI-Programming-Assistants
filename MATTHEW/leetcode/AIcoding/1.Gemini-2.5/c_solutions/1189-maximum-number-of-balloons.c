#include <string.h>

int maxNumberOfBalloons(char * text) {
    int counts[26] = {0};

    for (int i = 0; text[i] != '\0'; i++) {
        counts[text[i] - 'a']++;
    }

    int b_count = counts['b' - 'a'];
    int a_count = counts['a' - 'a'];
    int l_count = counts['l' - 'a'] / 2;
    int o_count = counts['o' - 'a'] / 2;
    int n_count = counts['n' - 'a'];

    int min_balloons = b_count;

    if (a_count < min_balloons) {
        min_balloons = a_count;
    }
    if (l_count < min_balloons) {
        min_balloons = l_count;
    }
    if (o_count < min_balloons) {
        min_balloons = o_count;
    }
    if (n_count < min_balloons) {
        min_balloons = n_count;
    }

    return min_balloons;
}