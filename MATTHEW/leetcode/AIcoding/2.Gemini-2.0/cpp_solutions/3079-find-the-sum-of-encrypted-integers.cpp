#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    long long sumOfEncryptedIntegers(vector<string>& encryptedNumbers) {
        long long sum = 0;
        for (string& s : encryptedNumbers) {
            sum += stoll(s);
        }
        return sum;
    }
};