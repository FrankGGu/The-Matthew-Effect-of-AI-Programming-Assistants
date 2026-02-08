#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string largestMerge(string s1, string s2) {
        string result;
        int i = 0, j = 0;
        while (i < s1.size() && j < s2.size()) {
            if (s1[i] > s2[j]) {
                result += s1[i];
                i++;
            } else if (s1[i] < s2[j]) {
                result += s2[j];
                j++;
            } else {
                if (s1.substr(i) > s2.substr(j)) {
                    result += s1[i];
                    i++;
                } else {
                    result += s2[j];
                    j++;
                }
            }
        }
        while (i < s1.size()) {
            result += s1[i];
            i++;
        }
        while (j < s2.size()) {
            result += s2[j];
            j++;
        }
        return result;
    }
};