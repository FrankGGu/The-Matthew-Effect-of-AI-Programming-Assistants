#include <string>
using namespace std;

class Solution {
public:
    string countAndSay(int n) {
        if (n == 1) return "1";
        string prev = "1";
        for (int i = 2; i <= n; i++) {
            string current = "";
            int j = 0;
            while (j < prev.size()) {
                char c = prev[j];
                int count = 0;
                int k = j;
                while (k < prev.size() && prev[k] == c) {
                    count++;
                    k++;
                }
                current += to_string(count) + c;
                j = k;
            }
            prev = current;
        }
        return prev;
    }
};