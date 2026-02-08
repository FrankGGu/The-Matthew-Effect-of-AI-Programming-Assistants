#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMovesToMakePalindrome(string s) {
        int n = s.size();
        int left = 0, right = n - 1;
        int moves = 0;
        vector<char> v(s.begin(), s.end());

        while (left < right) {
            if (v[left] == v[right]) {
                left++;
                right--;
            } else {
                int i = right;
                while (i > left && v[i] != v[left]) {
                    i--;
                }
                if (i == left) {
                    swap(v[i], v[i + 1]);
                    moves++;
                } else {
                    while (i < right) {
                        swap(v[i], v[i + 1]);
                        moves++;
                        i++;
                    }
                }
            }
        }
        return moves;
    }
};