#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string pathEncryption(string path) {
        string result = "";
        for (char c : path) {
            if (c == '/') {
                result += '.';
            } else {
                result += c;
            }
        }
        return result;
    }
};