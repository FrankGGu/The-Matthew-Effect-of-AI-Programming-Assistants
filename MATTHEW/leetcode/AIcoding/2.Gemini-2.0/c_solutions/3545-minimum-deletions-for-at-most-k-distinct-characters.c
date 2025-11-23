#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDeletions(char * s, int k){
    int n = strlen(s);
    int freq[26] = {0};
    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }

    if (count <= k) {
        return 0;
    }

    int arr[26];
    int arr_size = 0;
    for(int i=0; i<26; i++){
        if(freq[i] > 0){
            arr[arr_size++] = freq[i];
        }
    }

    int deletions = 0;
    while(count > k){
        int max_freq_index = 0;
        for(int i=1; i<arr_size; i++){
            if(arr[i] < arr[max_freq_index]){
                max_freq_index = i;
            }
        }

        deletions += arr[max_freq_index];
        arr[max_freq_index] = 0;
        count--;
    }

    return deletions;
}