#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> findProducts(vector<string> serialNumbers) {
        vector<string> result;
        for (const string& sn : serialNumbers) {
            if (sn.length() == 10 && isdigit(sn[0]) && isdigit(sn[1]) && isdigit(sn[2]) && 
                isdigit(sn[3]) && isdigit(sn[4]) && isdigit(sn[5]) && 
                isdigit(sn[6]) && isdigit(sn[7]) && isdigit(sn[8]) && isdigit(sn[9])) {
                result.push_back(sn);
            }
        }
        return result;
    }
};