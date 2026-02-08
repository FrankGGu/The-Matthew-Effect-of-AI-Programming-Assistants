#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numDifferentIntegers(string word) {
        unordered_set<string> distinctIntegers;
        string currentInteger = "";
        for (char c : word) {
            if (isdigit(c)) {
                currentInteger += c;
            } else {
                if (!currentInteger.empty()) {
                    int i = 0;
                    while (i < currentInteger.length() - 1 && currentInteger[i] == '0') {
                        i++;
                    }
                    distinctIntegers.insert(currentInteger.substr(i));
                    currentInteger = "";
                }
            }
        }
        if (!currentInteger.empty()) {
            int i = 0;
            while (i < currentInteger.length() - 1 && currentInteger[i] == '0') {
                i++;
            }
            distinctIntegers.insert(currentInteger.substr(i));
        }
        return distinctIntegers.size();
    }
};