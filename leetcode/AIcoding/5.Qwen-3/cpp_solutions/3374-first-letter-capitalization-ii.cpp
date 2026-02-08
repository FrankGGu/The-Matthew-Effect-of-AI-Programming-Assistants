#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string capitalizeTitle(string title) {
        int n = title.length();
        for (int i = 0; i < n; ++i) {
            if (i == 0 || title[i - 1] == ' ') {
                title[i] = toupper(title[i]);
            } else {
                title[i] = tolower(title[i]);
            }
        }
        return title;
    }
};