#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximizeSubarrays(int n, int nums[]) {
    int ans = 0;
    for (int i = -1; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            int temp_ans = 0;
            int current_or = 0;

            if (i == -1 && j == n) {
                for(int k = 0; k < n; ++k){
                    current_or |= nums[k];
                    if(current_or == 0){
                        temp_ans++;
                        current_or = 0;
                    }
                }
                if(current_or != 0) current_or = 0;
                ans = (temp_ans > ans) ? temp_ans : ans;
                continue;
            }

            if(i == -1){
                for(int k = 0; k < n; ++k){
                    if(k == j) continue;
                    current_or |= nums[k];
                    if(current_or == 0){
                        temp_ans++;
                        current_or = 0;
                    }
                }
                if(current_or != 0) current_or = 0;
                ans = (temp_ans > ans) ? temp_ans : ans;
                continue;
            }

            if(j == n){
                for(int k = 0; k < n; ++k){
                    if(k == i) continue;
                    current_or |= nums[k];
                    if(current_or == 0){
                        temp_ans++;
                        current_or = 0;
                    }
                }
                if(current_or != 0) current_or = 0;
                ans = (temp_ans > ans) ? temp_ans : ans;
                continue;
            }

            for (int k = 0; k < n; ++k) {
                if (k == i || k == j) continue;
                current_or |= nums[k];
                if (current_or == 0) {
                    temp_ans++;
                    current_or = 0;
                }
            }
            if(current_or != 0) current_or = 0;
            ans = (temp_ans > ans) ? temp_ans : ans;
        }
    }

    int temp_ans = 0;
    int current_or = 0;
    for(int k = 0; k < n; ++k){
        current_or |= nums[k];
        if(current_or == 0){
            temp_ans++;
            current_or = 0;
        }
    }
    if(current_or != 0) current_or = 0;
    ans = (temp_ans > ans) ? temp_ans : ans;

    return ans;
}