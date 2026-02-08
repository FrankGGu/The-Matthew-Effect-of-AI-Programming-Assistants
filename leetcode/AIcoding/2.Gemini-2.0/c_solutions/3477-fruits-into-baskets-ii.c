#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalFruit(int* fruits, int fruitsSize) {
    int maxFruits = 0;
    int basket1 = -1, basket2 = -1;
    int basket1Count = 0, basket2Count = 0;
    int start = 0;

    for (int end = 0; end < fruitsSize; end++) {
        if (fruits[end] == basket1 || basket1 == -1) {
            basket1 = fruits[end];
            basket1Count++;
        } else if (fruits[end] == basket2 || basket2 == -1) {
            basket2 = fruits[end];
            basket2Count++;
        } else {
            maxFruits = (maxFruits > end - start) ? maxFruits : end - start;

            if(basket1Count == 0){
                basket1 = fruits[end];
                basket1Count = 1;
            } else if(basket2Count == 0){
                basket2 = fruits[end];
                basket2Count = 1;
            } else {

                int lastBasket1Index = -1, lastBasket2Index = -1;
                for(int i = end - 1; i >= start; i--){
                    if(fruits[i] == basket1){
                        lastBasket1Index = i;
                        break;
                    }
                }
                for(int i = end - 1; i >= start; i--){
                    if(fruits[i] == basket2){
                        lastBasket2Index = i;
                        break;
                    }
                }
                if(lastBasket1Index < lastBasket2Index){
                    start = lastBasket1Index + 1;
                    basket1 = fruits[end];
                    basket1Count = end - lastBasket1Index;
                    basket2Count = lastBasket1Index - start + 1;
                    for(int i = start; i < lastBasket1Index; i++){

                    }

                } else {
                    start = lastBasket2Index + 1;
                    basket2 = fruits[end];
                    basket2Count = end - lastBasket2Index;
                    basket1Count = lastBasket2Index - start + 1;

                }
            }

        }
    }

    maxFruits = (maxFruits > fruitsSize - start) ? maxFruits : fruitsSize - start;

    return maxFruits;
}