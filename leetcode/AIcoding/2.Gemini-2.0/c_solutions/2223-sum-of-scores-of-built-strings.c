#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long sumScores(char * s){
    int n = strlen(s);
    int *z = (int*)malloc(sizeof(int) * n);
    z[0] = n;
    int l = 0, r = 0;
    for(int i = 1; i < n; i++){
        if(i > r){
            l = r = i;
            while(r < n && s[r - l] == s[r]){
                r++;
            }
            z[i] = r - l;
            r--;
        } else {
            int k = i - l;
            if(z[k] < r - i + 1){
                z[i] = z[k];
            } else {
                l = i;
                while(r < n && s[r - l] == s[r]){
                    r++;
                }
                z[i] = r - l;
                r--;
            }
        }
    }
    long long sum = n;
    for(int i = 1; i < n; i++){
        sum += z[i];
    }
    free(z);
    return sum;
}