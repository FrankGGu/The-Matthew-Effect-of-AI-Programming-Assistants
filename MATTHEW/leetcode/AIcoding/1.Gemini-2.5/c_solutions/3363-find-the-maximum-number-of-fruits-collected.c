#include <string.h> // For memset

int totalFruit(int* fruits, int fruitsSize) {
    if (fruitsSize == 0) {
        return 0;
    }

    static int freq[100000]; 
    memset(freq, 0, sizeof(freq));

    int left = 0;
    int max_fruits = 0;
    int distinct_types = 0;

    for (int right = 0; right < fruitsSize; ++right) {
        if (freq[fruits[right]] == 0) {
            distinct_types++;
        }
        freq[fruits[right]]++;

        while (distinct_types > 2) {
            freq[fruits[left]]--;
            if (freq[fruits[left]] == 0) {
                distinct_types--;
            }
            left++;
        }

        int current_window_size = right - left + 1;
        if (current_window_size > max_fruits) {
            max_fruits = current_window_size;
        }
    }

    return max_fruits;
}