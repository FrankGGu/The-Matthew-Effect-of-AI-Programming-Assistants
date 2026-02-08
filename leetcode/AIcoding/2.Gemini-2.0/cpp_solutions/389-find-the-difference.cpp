#include <string>
#include <numeric>

class Solution {
public:
    char findTheDifference(std::string s, std::string t) {
        int sumS = std::accumulate(s.begin(), s.end(), 0);
        int sumT = std::accumulate(t.begin(), t.end(), 0);
        return (char)(sumT - sumS);
    }
};