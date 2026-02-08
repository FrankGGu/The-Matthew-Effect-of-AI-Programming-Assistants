#include <iostream>
#include <vector>
#include <string>
#include <cctype>

using namespace std;

class Solution {
public:
    string capitalizeTitle(string title) {
        int n = title.length();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && title[j] != ' ') {
                j++;
            }
            if (j - i == 1) {
                title[i] = toupper(title[i]);
            } else {
                title[i] = tolower(title[i]);
                for (int k = i + 1; k < j; k++) {
                    title[k] = tolower(title[k]);
                }
                title[j - 1] = toupper(title[j - 1]);
            }
            i = j + 1;
        }
        return title;
    }
};