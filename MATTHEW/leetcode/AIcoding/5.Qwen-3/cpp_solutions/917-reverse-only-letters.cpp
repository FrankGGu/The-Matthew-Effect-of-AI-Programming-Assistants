#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string reverseOnlyLetters(string S) {
        int left = 0;
        int right = S.size() - 1;

        while (left < right) {
            if (!isalpha(S[left])) {
                left++;
            } else if (!isalpha(S[right])) {
                right--;
            } else {
                swap(S[left], S[right]);
                left++;
                right--;
            }
        }

        return S;
    }
};