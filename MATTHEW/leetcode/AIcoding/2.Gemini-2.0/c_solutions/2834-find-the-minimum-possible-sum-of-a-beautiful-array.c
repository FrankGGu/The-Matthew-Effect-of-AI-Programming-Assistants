#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumPossibleSum(int n, int target) {
    int sum = 0;
    int count = 0;
    int i = 1;
    while (count < n) {
        if (i * 2 != target) {
            if (i * 2 > target || i * 2 <= 0) {
                sum += i;
                count++;
            } else {
                int found = 0;
                for(int j = 1; j <= sum && j < target/2 + 1 ; j++){
                    if(i == target - j){
                        found = 1;
                        break;
                    }
                }
                if(found == 0){
                    sum += i;
                    count++;
                }
            }
        }
        i++;
    }
    return sum;
}