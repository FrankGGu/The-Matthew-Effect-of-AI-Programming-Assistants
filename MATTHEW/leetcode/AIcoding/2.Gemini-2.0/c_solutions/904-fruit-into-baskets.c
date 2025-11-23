#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalFruit(int* fruits, int fruitsSize) {
    int max_fruits = 0;
    int basket1 = -1, basket2 = -1;
    int basket1_count = 0, basket2_count = 0;
    int start = 0;

    for (int i = 0; i < fruitsSize; i++) {
        if (fruits[i] == basket1) {
            basket1_count++;
        } else if (fruits[i] == basket2) {
            basket2_count++;
        } else if (basket1 == -1) {
            basket1 = fruits[i];
            basket1_count = 1;
        } else if (basket2 == -1) {
            basket2 = fruits[i];
            basket2_count = 1;
        } else {
            while (fruits[start] != basket1 && fruits[start] != basket2) {
                start++;
            }

            if (fruits[start] == basket1) {
                while (fruits[start] == basket1) {
                    start++;
                    basket1_count--;
                }
                if(basket1_count == 0){
                    basket1 = fruits[i];
                    basket1_count = 1;
                } else {
                    basket2 = fruits[i];
                    basket2_count = 1;
                }

            } else {
                while (fruits[start] == basket2) {
                    start++;
                    basket2_count--;
                }
                if(basket2_count == 0){
                    basket2 = fruits[i];
                    basket2_count = 1;
                } else {
                    basket1 = fruits[i];
                    basket1_count = 1;
                }
            }

        }

        int current_fruits = 0;
        for(int j = start; j <= i; j++){
            current_fruits++;
        }

        if (current_fruits > max_fruits) {
            max_fruits = current_fruits;
        }
    }

    return max_fruits;
}