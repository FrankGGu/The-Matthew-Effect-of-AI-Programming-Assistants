#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int product1;
    int product2;
    int frequency;
} Recommendation;

int compare(const void *a, const void *b) {
    Recommendation *r1 = (Recommendation *)a;
    Recommendation *r2 = (Recommendation *)b;
    if (r1->frequency != r2->frequency) {
        return r2->frequency - r1->frequency;
    } else if (r1->product1 != r2->product1) {
        return r1->product1 - r2->product1;
    } else {
        return r1->product2 - r2->product2;
    }
}

Recommendation* findProductRecommendations(int* products, int productsSize, int threshold, int* returnSize){
    int *freq = (int*)malloc(sizeof(int) * 10001);
    for(int i = 0; i < 10001; i++){
        freq[i] = 0;
    }

    for(int i = 0; i < productsSize; i++){
        freq[products[i]]++;
    }

    int count = 0;
    for(int i = 0; i < productsSize; i++){
        if(freq[products[i]] > 0){
            count++;
            freq[products[i]] = 0;
        }
    }

    int **pair_freq = (int**)malloc(sizeof(int*) * 10001);
    for(int i = 0; i < 10001; i++){
        pair_freq[i] = (int*)malloc(sizeof(int) * 10001);
        for(int j = 0; j < 10001; j++){
            pair_freq[i][j] = 0;
        }
    }

    for(int i = 0; i < productsSize; i++){
        for(int j = i + 1; j < productsSize; j++){
            pair_freq[products[i]][products[j]]++;
            pair_freq[products[j]][products[i]]++;
        }
    }

    int recommendation_count = 0;
    for(int i = 1; i <= 10000; i++){
        for(int j = i + 1; j <= 10000; j++){
            if(pair_freq[i][j] >= threshold){
                recommendation_count++;
            }
        }
    }

    Recommendation* recommendations = (Recommendation*)malloc(sizeof(Recommendation) * recommendation_count);
    int index = 0;
    for(int i = 1; i <= 10000; i++){
        for(int j = i + 1; j <= 10000; j++){
            if(pair_freq[i][j] >= threshold){
                recommendations[index].product1 = i;
                recommendations[index].product2 = j;
                recommendations[index].frequency = pair_freq[i][j];
                index++;
            }
        }
    }

    qsort(recommendations, recommendation_count, sizeof(Recommendation), compare);

    *returnSize = recommendation_count;

    for(int i = 0; i < 10001; i++){
        free(pair_freq[i]);
    }
    free(pair_freq);
    free(freq);

    return recommendations;
}