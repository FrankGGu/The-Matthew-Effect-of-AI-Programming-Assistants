#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int takeCharacters(char * s, int k){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }
    int count[3] = {0};
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') count[0]++;
        else if (s[i] == 'b') count[1]++;
        else count[2]++;
    }
    if (count[0] < k || count[1] < k || count[2] < k) return -1;

    int left = 0;
    int right = n - 1;
    int ans = 0;
    int a = 0, b = 0, c = 0;

    while (left <= right) {

        a = 0;
        b = 0;
        c = 0;
        for(int i = 0; i <= left; i++){
            if(s[i] == 'a') a++;
            else if(s[i] == 'b') b++;
            else c++;
        }

        int cur_a = a;
        int cur_b = b;
        int cur_c = c;

        int r = right;
        while(r > left){
            if(s[r] == 'a') cur_a++;
            else if(s[r] == 'b') cur_b++;
            else cur_c++;

            if(cur_a >= k && cur_b >= k && cur_c >= k){
                ans = n - (r - left -1);
                break;
            }
            r--;
        }

        if(cur_a >= k && cur_b >= k && cur_c >= k){
            break;
        }

        left++;
    }

    return ans;
}