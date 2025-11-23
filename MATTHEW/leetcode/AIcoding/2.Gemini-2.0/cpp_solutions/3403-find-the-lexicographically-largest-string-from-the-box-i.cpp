#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        int n = s.size();
        string smallest = s;

        for (int i = 0; i < n; ++i) {
            string rotated = s;
            rotate(rotated.begin(), rotated.begin() + (i * b) % n, rotated.end());

            for (int j = 0; j < 10; ++j) {
                string temp = rotated;
                if (temp[1] % 2 != 0) {
                    for(int k = 1; k < n; k += 2){
                        temp[k] = ((temp[k] - '0' + j * a) % 10) + '0';
                    }
                }

                if(temp < smallest){
                    smallest = temp;
                }
            }
        }

        return smallest;
    }
};