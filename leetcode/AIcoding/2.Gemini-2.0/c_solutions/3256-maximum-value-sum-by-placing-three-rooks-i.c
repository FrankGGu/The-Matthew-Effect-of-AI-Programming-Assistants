#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int n;
    scanf("%d", &n);
    int a[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }

    long long max_sum = LLONG_MIN;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == j) continue;
            for (int k = 0; k < n; k++) {
                if (k == i || k == j) continue;

                long long current_sum = 0;
                int temp[n];
                for(int l = 0; l < n; l++)
                    temp[l] = a[l];

                if(i/1 == j/1 || i/1 == k/1 || j/1 == k/1)
                    continue;

                current_sum += abs(temp[i]);
                current_sum += abs(temp[j]);
                current_sum += abs(temp[k]);

                max_sum = (current_sum > max_sum) ? current_sum : max_sum;
            }
        }
    }

    return (int)max_sum;
}