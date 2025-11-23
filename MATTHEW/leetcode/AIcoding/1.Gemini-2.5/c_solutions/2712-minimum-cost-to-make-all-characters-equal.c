#include <string.h>

long long minimumCost(char * s){
    int n = strlen(s);
    long long costToMakeAllZero = 0;
    long long costToMakeAllOne = 0;

    for (int i = 0; i < n; ++i) {
        if (s[i] == '1') {
            costToMakeAllZero += (long long)(i + 1);
        } else { // s[i] == '0'
            costToMakeAllOne += (long long)(i + 1);
        }
    }

    return (costToMakeAllZero < costToMakeAllOne) ? costToMakeAllZero : costToMakeAllOne;
}